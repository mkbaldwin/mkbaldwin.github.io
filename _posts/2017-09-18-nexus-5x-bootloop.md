---
title: Nexus 5x Boot Loop Adventures
categories: 
  - Android
date:  2017-09-18T20:35:00-0500
---

I've had a Google Nexus 5x phone for almost two years. I pre-ordered it as soon
as it was announced, and have generally been really happy with the phone. Last
weekend I woke up one morning to find my phone powered off and it wouldn't 
turn back on at all. This begins my adventure trying to troubleshoot my phone.

After leaving the phone plugged into the power adapter I was eventually
able to get the phone to power on enough to show the Google logo. However, 
it would always freeze up during the Android OS boot and then restart.
Only once did the device boot all the way and seem to function a while
before crashing again.

I was sometimes able to get into the fastboot and recovery menus. So, 
just to see if it helped, and assuming my data was lost anyway, I attempted
to wipe the cache and do a factory data reset which didn't really help.

Fortunately, I was able to get the device to boot again and had an 
opportunity to enable OEM unlocking on the bootloader.

After many Google searches I found others talking about experiencing the
same "boot loop" issue that sounded exactly like what I was experiencing.
Most of the posts concluded that the phone was deas and provided little
help or encouragement.

At this point my research lead to learning more about the CPU being used.
The Nexus 5x uses a [Snapdragon 808](https://www.qualcomm.com/products/snapdragon/processors/808) 
processor which has six-cores in a big.LITTLE configuration. It has two 
Cortex A57 "big" cores and four Cortex A53 "little" cores. This design is
used to balance power usage and performance.

The posts indicated that the problem in this phone and others using this 
chip were caused by malfunctions developing in the two big cores. I found a 
potential "*fix*" in the [xda-developers](https://forum.xda-developers.com/nexus-5x/general/untested-nexus-5x-bootloop-death-fix-t3641199)
forum. The suggestion was utilizing a customized boot image that disables
the two big cores and lets the phone operate on the four remaining little
cores.

So, at this point I decided to give it a try just to see what happend.
I utilized the fastboot utility to unlock my bootloader, and then followed
the article's instructions to flash the new boot image.

After flashing the phone started up immediately... no boot loop!

Initially this seemed pretty promising. I rebooted the phone many times 
and only had a few instances of it crashing during start up. I've also
had it freeze up and reboot mid-use a couple of times. I definitely wouldn't call 
this a fix, but it is a workaround to make the phone at least semi-functional.

At this point I still don't have enough confidence in it being reliable enough
to switch my service back. So, I will probably keep using an older phone
until Google's new phone announcement. I'm sad to see the old Nexus 5x go, it 
really was a great phone. Perhaps a Pixel 2, or even the essential phone could 
be in my future.

Regardless of the outcome, this was definitely an interesting learning experience 
troubleshooting hardware, and flashing new software onto a phone!