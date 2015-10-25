void DrawingSystems() {

  /* ------------------- White Particle System ----------------- */

  for (int i = 0; i < Nums; i ++) { // looping through the 1st array of notes 

    // what this mapping does is that it makes the the max amplitude in the middle of the screen depending on where the particles are located. 
    //in an earlier version was the amplitude mapped from 0 to height but this made the sound "clip" and distort when it went from max amplitude to 0 and vise versa
    // and with this new mapping it fixed that problem.

    if (particles[i].pos.y < height/2) // if the y position of any indivudual particle is less than height/2
    {
      float amp = map(particles[i].pos.y, 0, height/2-200, 0, maxAmp/(float)Nums); // mapping the amplitude to the y position of the any induvidual particle from 0 to height/2 -200 (top half of the screen) and mapping it to 0 to maxAmp divided by the numbers of notes to make sure that the amplitude doesn't reach too high
      wave[i].setAmplitude( amp ); // setting the first the amplitude to amp
    }
    if (particles[i].pos.y > height/2) // if the y position of any indivudual particle is greater than height/2
    {
      float amp2 = map(particles[i].pos.y, height/2+200, height, maxAmp/(float)Nums, 0); // mapping the amplitude to the y position of the any induvidual particle from height/2 +200 to height (bottom half of the screen) and mapping it to 0 to maxAmp divided by the numbers of notes to make sure that the amplitude doesn't reach too hi
      wave[i].setAmplitude( amp2 ); // setting the second amplitude to amp2
    }

    float freq = constrain( map( particles[i].pos.x, 0, width, 200, 1200 ), 200, 600 ); // constraining the frequency 
    float rez  = constrain( map( particles[i].pos.y, height, 0, 0, 1 ), 0, 1 ); // constraining the resonance
    moog[i].frequency.setLastValue( freq ); // setting the frequency of the moog filter
    moog[i].resonance.setLastValue( rez  ); // setting the resonance of the moog filter
    particles[i].update(); // updating the particle sytem
    particles[i].display(); // displating the particle system
  }

  /* ------------------- Blue Particle System ----------------- */

  for (int i = 0; i < Nums2; i ++) { // looping through the 2nd array of notes

    if (particles2[i].pos.y < height/2) //  if the y position of any indivudual particle is less than height/2
    {
      float amp = map(particles2[i].pos.y, 0, height/2-200, 0, maxAmp/(float)Nums2); // mapping the amplitude to the y position of the any induvidual particle from 0 to height/2 -200 (top half of the screen) and mapping it to 0 to maxAmp divided by the numbers of notes
      wave[i].setAmplitude( amp ); // setting the amplitude to amp
    }
    if (particles2[i].pos.y > height/2) // if the y position of any indivudual particle is greater than height/2
    {
      float amp2 = map(particles2[i].pos.y, height/2+200, height, maxAmp/(float)Nums2, 0); // mapping the amplitude to the y position of the any induvidual particle from height/2 +200 to height (bottom half of the screen) and mapping it to maxAmp to 0 
      wave[i].setAmplitude( amp2 ); // setting the amplitude to amp2
    } 

    float freq2 = constrain( map( particles2[i].pos.x, 0, width, 200, 1200 ), 200, 400 ); // constraining the frequency to the  particles x position
    wave2[i].frequency.setLastValue( freq2 ); // setting the frequency to freq2
    particles2[i].update(); // updating the particle system
    particles2[i].display(); // displaying the particle system
  }

  /* ------------------- Pad Particle -------------------- */

  // here we map the same way as the other to systems but from 0 to width/2 -200 and to width/2 + 200 to width becasuse in this system we are mapping 
  //the frequency (left to right) and not the amplitude to make the smooth transition from left to right and vise versa
  
  if (pad.pos.x < width/2)  // if pad's x position is less than width/2
  {  
    float freq = map(pad.pos.x, 0, width/2-200, 200, 800); // mapping pad.pos.x to 0 to width/2 -200 to the new value 200 to 800
    moog2.frequency.setLastValue( freq ); // setting the frequency of moog2 to be the mapped freq
  }
  if (pad.pos.x > width/2) // if pad's x position is greater than width/2
  {
    float freq2 = map(pad.pos.x, width/2+200, width, 800, 200); // mapping pad.pos.x to width/2 +200  to width to the new value 800 to 200
    moog2.frequency.setLastValue( freq2 );  // setting the frequency of moog2 to be the mapped freq2
  } 

  float rez  = constrain( map( pad.pos.y, 0, height, 0, 1 ), 0, 0.8 ); // mapping and constraining the resonance to the pad particles y positiion
  moog2.resonance.setLastValue( rez  ); // setting the resonace of the 2nd moog filter
  pad.update(); // updating the background music particle 
  pad.display(); //displaying the background music particle
}

