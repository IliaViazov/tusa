(
s.options.sampleRate = 44100;
s.options.numOutputBusChannels_(20);
s.options.numInputBusChannels_(1);
s.reboot;
)

(
s.waitForBoot(
s.newBusAllocators;
(~a=Bus.control;
~b=Bus.control;)
;
(SynthDef(\spat, {
	arg a,b;
	var sig;
	sig = LFSaw.ar(LFNoise0.ar(3).range(80,600));
	sig = VSTPlugin.ar(sig,16, id: \ambix,params: [0,a,1,b].poll);
	sig = VSTPlugin.ar (sig,20,id: \mcfx);
	Out.ar(0,sig);
}).add
);


(
~spat = Synth(\spat);
~ambix=VSTPluginController (~spat, \ambix);
~mcfx=VSTPluginController(~spat, \mcfx);)
;

~ambix.open("ambix_encoder_o3",editor:true);
~mcfx.open("mcfx_convolver24",editor:true);

~spat.map(0,~a);
~spat.map(1,~b);
)

)

~ambix.editor;
~ambix.gui
~mcfx.editor;
~mcfx.loadPreset("/Users/ilia_viazov/Desktop/Projects/tidalueb/IKO 001020 Configuration.conf")