# FORMS
A generative Visual Music framework

https://youtu.be/Xz71SGf5r9M

FORMS is an heterogeneous collection of codes and applications which allow the synthesis of sonograms and its sonification.
In no way FORMS is a finished application, and this repository is just a room for the curious or those who want to collaborate on the project development.
We give no support for end-users, as the project is still on its early functionality stage.

It is comprised of 3 main applications

A) FORMS_SPECTRUM_2022
This folder holds the Processing code which is in charge of synthesizing the sonograms. It includes myriads of algorithms oriented at drawing melodic, harmonic or rhythmic elements, which can further be mixed to generate interesting Visual Music.
All functions in the Processing code are externally called from a MAX/MSP patch that serves both as a GUI and a sonification engine for the resulting images

B) MAX
This folder holds the MAX/MSP patch and abstractions that allow the sonification of the processing generated pngs. It also features a number of live performance tools which extend the possibilities when playing with the real-time sonification of images

C) OFxScroller
A binary featuring an application that receives the processing generated pngs and scrolls them using the phasor data coming from MAX/MSP

To make the whole thing work, you need to:

1) execute the OFxScroller2 binary
2) open and execute FORMS_SPECTRUM_2022.pde Processing sketch
3) open the MAX patch FORMS_LIVE_6_M1.maxpat, and start the DAC~
If you get no sound from Max, please check the vst chain and delete all vst objects while connecting the audio directly to the DAC~
