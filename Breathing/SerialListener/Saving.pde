boolean saved = false;
ArrayList<String> list;
String fileName = "out.txt";

//Output
void Init(){
  list = new ArrayList<String>();
}

void Add(String val){
  list.add(val);
}

void Save(){
  saveStrings(fileName, list.toArray(new String[list.size()]));
}
