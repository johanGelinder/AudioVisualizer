void button() {

  if (mouseX > 290 && mouseX < 910 && mouseY > 395 && mouseY < 470) { // if the mouse hover over this position
    stroke(255); // white stroke on the rectangle
    noFill();  // calling no fill on the rectangle
    strokeWeight(6); // thickness of the stroke
    rect(width/2, 430, 615, 70); // drawing the rectangle over the other rectangle
  }
}

