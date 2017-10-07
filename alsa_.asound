pcm.!default {
  type asym
   playback.pcm {
     type plug
     slave.pcm "hw:0,0"
   }
   capture.pcm {
     type plug
     slave.pcm "hw:1,0"
#    slave.rate 16000
   }
}

pcm.rate_convert{
 type plug
slave {
	pcm "hw:1,0"
rate 16000
}
}
