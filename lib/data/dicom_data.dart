const List<String> listSite = ['Head & Neck', 'GU: Prostate', 'CNS: Brain'];

const List<String> listAlgo = ['Algo 1', 'Algo 2', 'Algo 3'];

// This will be the fraction of the total DICOM bytes analyzed for header tags/features (usually 1% is more than enough)
const double fractionLengthOfInterest = 0.01;

const Map<String, List<int>> mapListTag = {
  'accession': [8, 0, 80, 0],
  'series': [32, 0, 17, 0],
  'name': [16, 0, 16, 0],
  'id': [16, 0, 32, 0],
  'dob': [16, 0, 48, 0],
};