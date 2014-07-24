package cow

import junit.framework.Assert

class BackendSimulatorService {
    Random random = new Random()


    String rn (int smallest,int biggest) {
        int rawRandom = random.nextInt(biggest-smallest)
        if (smallest > biggest) {
            println "smallest > biggest.  What were you thinking?"
            Assert  (smallest <= biggest)
        }
        int rawWithRangeRestriction =  (rawRandom%(biggest-smallest)) +  smallest
        return  rawWithRangeRestriction.toString()
    }


    String simulatedRows(int firstIndex,
                         int numberRowsRequested,
                         int totalNumberOfSimulatedRecords ) {
        StringBuilder stringBuilder = new StringBuilder();
        int indexCounter = firstIndex
        for (int i = 0; i < numberRowsRequested; i++) {
            if ((firstIndex+i) < totalNumberOfSimulatedRecords) {
                String temporaryDate = "${rn(2000, 2012)}-${rn(1, 12)}-${rn(1, 12)}"
                stringBuilder << "{\"id\":\"${indexCounter++}\",\"invdate\":\"${temporaryDate}\",\"name\":\"${rn(0, 9)}/${rn(10, 100)}\",\"note\":\"note${rn(0, 3)}\",\"amount\":\"${rn(1, 400)}.${rn(0, 99)}\",\"tax\":\"${rn(1, 10)}.00\",\"AC50\":\"210.00\"}"
                if (((i + 1) < numberRowsRequested)&&
                        ((firstIndex+i+1) < totalNumberOfSimulatedRecords)){
                    stringBuilder << ","
                }
            }
        }
        return stringBuilder.toString()
    }

}
