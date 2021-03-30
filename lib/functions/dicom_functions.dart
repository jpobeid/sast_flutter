import 'dart:convert';

import 'package:sast_project/data/dicom_data.dart' as dicoms;

String readDicomTag(List<int> listBytes, String strTag) {
  List<int> listTag = dicoms.mapListTag[strTag];
  AsciiDecoder decoder = AsciiDecoder(allowInvalid: true);
  for (int i = 0;
      i < (listBytes.length * dicoms.fractionLengthOfInterest).toInt();
      i++) {
    bool isMatch = (listBytes[i] == listTag[0] &&
        listBytes[i + 1] == listTag[1] &&
        listBytes[i + 2] == listTag[2] &&
        listBytes[i + 3] == listTag[3]);
    if (isMatch) {
      int nTagLength = getListLength(listBytes, i);
      int j = (i + 8);
      return decoder.convert(listBytes.getRange(j, j + nTagLength).toList());
    }
  }
  return null;
}

void makeAnonListBytes(List<int> listBytes) {
  const int _nAsciiX = 88;
  const int _nAscii0 = 48;

  List<int> _listPatientName = dicoms.mapListTag['name'];
  List<int> _listPatientID = dicoms.mapListTag['id'];
  List<int> _listPatientDOB = dicoms.mapListTag['dob'];
  int _iName = 0;
  int _iID = 0;
  int _nLengthOfInterest =
      (listBytes.length * dicoms.fractionLengthOfInterest).toInt();

  // First for-loop to detect name and ID fields
  if (listBytes.isNotEmpty &&
      dicoms.fractionLengthOfInterest > 0 &&
      dicoms.fractionLengthOfInterest <= 1) {
    for (int i = 0; i < _nLengthOfInterest; i++) {
      if (listBytes[i] == _listPatientName[0] &&
          listBytes[i + 1] == _listPatientName[1] &&
          listBytes[i + 2] == _listPatientName[2] &&
          listBytes[i + 3] == _listPatientName[3]) {
        int nNameLen = getListLength(listBytes, i);
        _iName = (i + 8);
        int j = _iName + nNameLen;
        if (listBytes[j] == _listPatientID[0] &&
            listBytes[j + 1] == _listPatientID[1] &&
            listBytes[j + 2] == _listPatientID[2] &&
            listBytes[j + 3] == _listPatientID[3]) {
          int nIDLen = getListLength(listBytes, j);
          _iID = (j + 8);
          int k = _iID + nIDLen;
          for (int i0 = _iName; i0 < j; i0++) {
            listBytes[i0] = _nAsciiX;
          }
          for (int i0 = _iID; i0 < k; i0++) {
            listBytes[i0] = _nAscii0;
          }
          break;
        }
      }
    }
  }

  // Second for-loop to detect DOB
  if (_iID != 0) {
    for (int i = _iID; i < _nLengthOfInterest; i++) {
      if (listBytes[i] == _listPatientDOB[0] &&
          listBytes[i + 1] == _listPatientDOB[1] &&
          listBytes[i + 2] == _listPatientDOB[2] &&
          listBytes[i + 3] == _listPatientDOB[3]) {
        int nDOBLen = getListLength(listBytes, i);
        int j = (i + 8) + nDOBLen;
        for (int i0 = (i + 8); i0 < j; i0++) {
          listBytes[i0] = _nAscii0;
        }
        break;
      }
    }
  }
}

int getListLength(List<int> listBytes, int index) {
  // This will ideally cover the cases of implicit VR little endian (index + 4) or explicit VR little endian (index + 6) since the VR occupies 2 bytes
  return listBytes[index + 6] != 0
      ? listBytes[index + 6]
      : listBytes[index + 4];
}
