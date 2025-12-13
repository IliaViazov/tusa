(
s.reboot;
s.waitForBoot {
	~src = Array.new;
	~mypath = PathName(Quarks.folder ++ "/Dirt-Samples");

// keep the loaders!
	~loaders = ~mypath.entries
	.select(_.isFolder)
    .collect { |item|
        FluidLoadFolder(item.fullPath)
    };

// actually load
	~loaders.do { |loader|
		loader.postln;
		loader.play(s);
	};
};
)

~loaders.do {
	|loader|
	~src = ~src.add(loader.buffer);
};


~src = FluidLoadFolder(Quarks.folder ++ "/Dirt-Samples/808bd").play;
// slice with basic parameters
(
~indices = Buffer(s);
FluidBufOnsetSlice.processBlocking(s,~src.buffer,metric:9,indices:~indices,threshold:0.4,action:{
    "found % slice points".format(~indices.numFrames).postln;
    "with an average length of % seconds per slice".format(~src.buffer.duration / ~indices.numFrames).postln;
});
)

(
~mfccs = Buffer(s);
FluidBufMFCC.processBlocking(s,~src.buffer,features:~mfccs,action:{"done".postln;})
)

~src.buffer.plot;


~mfccs.plot;
// display
FluidWaveform(~src.buffer,~indices);

//loops over a slice from onset to the next slice point using MouseX to choose which
(
{
    var gate_index = MouseX.kr(0,~indices.numFrames-1).poll(label:"slice index");
    var start = BufRd.kr(1,~indices,gate_index,1,1);
    var end = BufRd.kr(1,~indices,gate_index+1,1,1);
    var phs = Phasor.ar(0,BufRateScale.ir(~src.buffer),start,end);
    BufRd.ar(1,~src.buffer,phs,1,4).dup;
}.play;
)