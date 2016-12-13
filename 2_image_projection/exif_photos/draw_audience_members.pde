JSONArray imagesJSON; // array of all exif data
PFont AlteHaas;

AudienceMember audienceMem1;
AudienceMember audienceMem2;
AudienceMember audienceMem3;

void setupAudienceMembers() {
 loadData(dataPath); // set in set_params 

 audienceMem1 = new AudienceMember(am1ImagePath, am1ImageFileName);
 audienceMem2 = new AudienceMember(am2ImagePath, am2ImageFileName);
 audienceMem3 = new AudienceMember(am3ImagePath, am3ImageFileName);
 
 AlteHaas = loadFont("AlteHaasGrotesk-20.vlw");
 
 
}

void drawAudienceMembers() {
  if (am1 == true) {
    audienceMem1.display();
  }
  
  if (am2 == true) {
    audienceMem2.display();
  }
  
  if (am3 == true) {
    audienceMem3.display();
  }
}


void loadData(String jsonFile) { 
  imagesJSON = loadJSONArray(jsonFile);
}