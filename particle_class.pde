class Particle {

  float id, s, n; // initializing float values
  PVector pos; // initializing the position vector

  // constructor
  Particle(PVector _pos) { 

    pos =_pos;
    s = random(1, 4); // setting s to a random number between 1 to 4
  }

  void update() { 

    collison(); //calling the collision function
    id += 0.007; // increasing id for each frame
    n = (noise(id, pos.x/500, pos.y/600)-0.5)*600;  // adding noise and storing the values in n
    pos.x += cos(radians(n))*s; // Calculates the cosine of the angle n and adding it to pos.x every frame
    pos.y += sin(radians(n))*s; // Calculates the sine of the angle n and adding it to pos.y every frame
  }

  void display() { 

    stroke(255);  // setting the colour to white
    strokeWeight(2); // setting the size of the particles
    point(pos.x, pos.y, pos.z); // drawing the point using pos.x, pos.y and pos.z
  }

  void collison() { // checking if the particles goes of screen and if they do they apear on the opposite side

    if (pos.x > width) pos.x = 0;
    if (pos.x < 0) pos.x = width;
    if (pos.y > height) pos.y = 0;
    if (pos.y < 0) pos.y = height;
  }
}

