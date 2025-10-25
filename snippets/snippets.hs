d1 $ "techno" <| n (run "<23 10>") #speed "11.2 9 1.2 20 30 <[0.1 10] 50>"

d1 $ jux(hurry "<10 11> 1 .90")  $ "auto" <| n (run "<.11 1.2 .9 0.1>")

d1 $ jux(hurry "3.2 <10.2 1.0> 3.04 0.9") $ "auto drum 808" <| n (run "<7.2 1? [4 3.2?] 3 10>")

:{
d1 $ jux (hurry 2.1)$ s "superfork" <| note (run "<30 32 12>" |/ "10 20 <120 5 23>")
# octer 1
# freeze 1
# leslie 1
# delay 0.5
# squiz 1
:}

d2 $ "supergrind supersnare sostoms sossnare" <| n (run 10 |- 1200 |/ 50)


d1 $ "808bd" <| n (run 10)
d2 $ "808ht" <| n (run 7)
d3 $ slow "2 0.1 2.3 0.9" $ "808lt" <| n (run 12 |% "<3 1 2 3 14 12>")
d4 $ jux(hurry 2) $ "east" <| n (run "<11 10 <23 10> 30 . 0.9>")
d5 $ "bd" #cps "<0.9 10 20 0.1 <40 100> 1> 2"
d6 $ "hh!32"
d7 $ jux (hurry "<[10 2] [20 0.1] 30 100 200>") $ "cp!16 sn!23" #speed "10 20 0.1 2" #pan rand
d8 $ "bd!10" #gain 2
d9 $ "trump" <| n (run "10 2 3 4 5 1")


d8 $ "breath ~ ~ ~ ~ breath*10 ~ breath!12" #octersub 1 #gain 2 #ringf 200 #ring 1 #leslie 1 #real (smooth "1 0.3 4.4 10.1 2.3") #imag (smooth "1 0.2 0.3 0.4 1") #cps "<10 1 0.5 20 32>"


d1 $ jux(hurry 2)$ "bd sn cp sn" <| n (run 201) #gain rand #pan rand
d2 $ "cp!16 sn!23" #cps "10 20 0.1 2"
d3 $ "f f:2" <| n (run 120) #octer saw
