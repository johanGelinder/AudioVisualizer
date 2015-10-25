// Audio Visual Computing, Final Project
// By Johan Gelinder & Cormac joyce
// Music by Johan Gelinder

// importing Minim
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim; // intializing Minim 
AudioOutput out; // initializing AudioOutput
Oscil[] wave; // intitializing the array of oscillators for the 1st particle system
Oscil[] wave2; // intitializing the 2nd array for the 2nd particle system
Frequency freq; // intitializing the Frequency
MoogFilter[] moog; //intitializing the array of moogFilters
MoogFilter moog2; // intitializing the 2nd moog filter to be used for the background music
FilePlayer fileplayer; // intitializing the filePlayer which allows you to patch them into a UGen graph 
String fileName = "paaad2.mp3"; //creating a string called fileName and making it equal to the background music .mp3 file

float maxAmp = 1; // setting the value for the maximum amplitude
PVector pos, pos2, padPos; // initializing the position vectors for the different particle systems
PImage play, play2, text, logo; // Initializing the PImage variables for the menu screen
int state = 0; // variable for the menu state.

String notes [] = { 
  "C3", "E3", "G3", "B3", "E4", "E2", "G2", "F#3", "G2", "C5", "A4"} ; // filling the first array with these notes
String notes2 [] = { 
  "F3", "G3", "D2", "G2", "C2", "E2", "C1", "C0", "E1", "A1", "B1" }; // filling the 2nd array with these notes

int Nums = notes.length; // setting Nums to be equal to the 1st array of notes
int Nums2 = notes2.length; // settings Nums2 to be equal to the 2nd array of notes
Particle[] particles = new Particle[Nums]; // initializing the 1st particle class and filling the array with the 1st array of notes
Particle2[] particles2 = new Particle2[Nums2];  // initializing the 2nd particle class and filling the array with the 2nd array of notes
Pad pad; // initializing the Pad class for the background music

void setup() {

  size(1200, 800, P3D); // setting the size of the canvas and render the sketch in 3D
  background(0); // setting the background to black, calling the background in draw to be able to make a trail effect on the particles
  rectMode(CENTER); // setting the different modes to CENTER
  ellipseMode(CENTER);
  textAlign(CENTER);
  imageMode(CENTER);

  minim = new Minim(this); // creating Minim
  out = minim.getLineOut(); // creating the minim output
  wave = new Oscil[Nums]; // creating the 2 oscillators and filling it with the 1st and 2nd array of notes
  wave2 = new Oscil[Nums2];
  moog = new MoogFilter[Nums]; // creating first moog filter and filling it with the 1st array of notes
  moog2 = new MoogFilter(600, 0.5); // creating the 2nd moog filter for the background music and setting it to the values 600, 0.5

  text = loadImage("text.png"); // loading the text image
  logo = loadImage("amb.png"); // loading the logo image

    for (int i = 0; i < Nums; i ++) { // looping through the first array of notes

    pos = new PVector(width/2, height/2 , 0); // creating a position vector for the 1st particle system
    particles[i] = new Particle(pos); // creating the particle class and passing through pos through the constructor

    wave[i] = new Oscil( 20, 0, Waves.SAW); // Creating a new oscillator for each note and setting it to a frequency, an amplitude and a saw wave
    wave[i].setFrequency( Frequency.ofPitch(notes[i])); // setting a oscil wave to the frequency of notes[j]. Frequency.ofPitch is a method belonging to Oscil that uses a string (such as C4, A3) to define the tone being played instead of defining it Hz
    moog[i] = new MoogFilter( 1200, 0.5 ); // creating a moog filter for every note in the array
    wave[i].patch(moog[i]).patch( out ); // patching the notes through the moog filter then through the output
  }

  for (int i = 0; i < Nums2; i ++ ) { // looping through the 2nd array of notes

    pos2 = new PVector(width/2, height/2 , 0); // creating a position vector for the 2nd particle system
    particles2[i] = new Particle2(pos2); // creating the particle class and passing through pos2 through the constructor
    wave2[i] = new Oscil(20, 0, Waves.SINE); // Creating a new oscillator for each note and setting it to a frequency, an amplitude and a sine wave
    wave2[i].setFrequency( Frequency.ofPitch(notes2[i])); // setting a oscil wave to the frequency of notes[j]. Frequency.ofPitch is a method belonging to Oscil that uses a string (such as C4, A3) to define the tone being played instead of defining it Hz
    wave2[i].patch( out ); // patching the notes through the output
  }

  padPos = new PVector(width/2, height/2 , 0); // creating a position vector for the pad particle
  pad = new Pad(padPos); // creating the Pad class and passing padPos through the constructor

  AudioRecordingStream myFile = minim.loadFileStream( fileName, 1024, true ); // get the AudioRecordingStream from Minim, the FilePlayer will control which file to load, the size of the buffer and true means that the file is loading into memory
  fileplayer = new FilePlayer( myFile ); // this opens the file and puts it in the "play" state.
  fileplayer.patch(moog2).patch( out ); // patching the audio file through the 2nd moog filter and then through the output
  fileplayer.loop(); // looping the audio file
}

void draw() {

  switch(state) {

    /* ----------------------- Menu --------------------- */
    
  case 0 : 

    pushMatrix();
    fill(0); // black filling
    strokeWeight(10); // thickness of the stroke
    stroke(255); // white stroke
   // ellipse(width/2, 200, 320, 320); // drawing a ellipse behind the logo
    //image(logo, width/2, 200); // displaying the logo image

    fill(0); //filling the rectangle black
    stroke(255, 40); // setting the stroke to white and with a oppacity to 40
    strokeWeight(5); // thickness of the stroke
    //rect(width/2, 430, 615, 70); // wrapping the title in a rectangle to make the text image more clear because background is not called every frame
    //image(text, width/2, 430); // displaying the text
    button(); // calling the button function which display the play button image and the highlight image
    popMatrix();

    break;
    
/* ----------------------- Visualizer --------------------- */

  case 1 : 

    rectMode(CORNER);
    noStroke(); // setting noStroke on the recangle
    fill(0, 5); // filling the rectangle black with a very low oppacity to create a fade out effect on the particle trails
    rect(0, 0, width, height); // drawing a rectangle over the whole screen
    DrawingSystems(); // calling the function which draws all the particle systems

      break;
  }
}

//void mousePressed() 
//{ 
//
//  if (mouseX > 290 && mouseX < 910 && mouseY > 395 && mouseY < 470 ) { // if you click on the text button you move to state 1
//    state = 1;
//  }
//}

void keyPressed() 
{
if( key == ' ') {
  state = 1;
}
  for (int i = 0; i < Nums2; i++) { // looping through all the notes in the Nums2 array

    if ( key == '1' ) moog[i].type = MoogFilter.Type.LP; // By default the low pass filter type is activated
    if ( key == '2' ) moog[i].type = MoogFilter.Type.BP; // By pressing '2' on the keyboard you change the filter type to band pass
  }
}

