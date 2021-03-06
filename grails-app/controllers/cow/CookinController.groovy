package cow

import grails.converters.JSON

class CookinController {
     def fruits = """{
    "name": "Fruits",
    "data": [
        {
            "name": "Apple",
            "description": "The apple is the pomaceous fruit of the apple tree, species Malus domestica in the rose family. It is one of the most widely cultivated tree fruits, and the most widely known of the many members of genus Malus that are used by humans.",
            "amount_grams": 100,
            "calories": 52,
            "color": "#FF5149"
        },
        {
            "name": "Orange",
            "description": "The orange is the fruit of the citrus species Citrus × ​sinensis in the family Rutaceae. The fruit of the Citrus sinensis is called sweet orange to distinguish it from that of the Citrus aurantium, the bitter orange.",
            "amount_grams": 100,
            "calories": 47,
            "color": "#E89546"
        },
        {
            "name": "Pear",
            "description": "The pear is any of several tree and shrub species of genus Pyrus, in the family Rosaceae. It is also the name of the pomaceous fruit of these trees.",
            "amount_grams": 100,
            "calories": 57,
            "color": "#A1E846"
        },
        {
            "name": "Banana",
            "description": "A banana is an edible fruit produced by several kinds of large herbaceous flowering plants in the genus Musa.",
            "amount_grams": 100,
            "calories": 89,
            "color": "#FFE159"
        }
    ]
}
""".toString()

    def aapl = """date\tclose
1-May-12\t582.13
30-Apr-12\t583.98
27-Apr-12\t603.00
26-Apr-12\t607.70
25-Apr-12\t610.00
24-Apr-12\t560.28
23-Apr-12\t571.70
20-Apr-12\t572.98
19-Apr-12\t587.44
18-Apr-12\t608.34
17-Apr-12\t609.70
16-Apr-12\t580.13
13-Apr-12\t605.23
12-Apr-12\t622.77
11-Apr-12\t626.20
10-Apr-12\t628.44
9-Apr-12\t636.23
5-Apr-12\t633.68
4-Apr-12\t624.31
3-Apr-12\t629.32
2-Apr-12\t618.63
30-Mar-12\t599.55
29-Mar-12\t609.86
28-Mar-12\t617.62
27-Mar-12\t614.48
26-Mar-12\t606.98
23-Mar-12\t596.05
22-Mar-12\t599.34
21-Mar-12\t602.50
20-Mar-12\t605.96
19-Mar-12\t601.10
16-Mar-12\t585.57
15-Mar-12\t585.56
14-Mar-12\t589.58
13-Mar-12\t568.10
12-Mar-12\t552.00
9-Mar-12\t545.17
8-Mar-12\t541.99
7-Mar-12\t530.69
6-Mar-12\t530.26
5-Mar-12\t533.16
2-Mar-12\t545.18
1-Mar-12\t544.47
29-Feb-12\t542.44
28-Feb-12\t535.41
27-Feb-12\t525.76
24-Feb-12\t522.41
23-Feb-12\t516.39
22-Feb-12\t513.04
21-Feb-12\t514.85
17-Feb-12\t502.12
16-Feb-12\t502.21
15-Feb-12\t497.67
14-Feb-12\t509.46
13-Feb-12\t502.60
10-Feb-12\t493.42
9-Feb-12\t493.17
8-Feb-12\t476.68
7-Feb-12\t468.83
6-Feb-12\t463.97
3-Feb-12\t459.68
2-Feb-12\t455.12
1-Feb-12\t456.19
31-Jan-12\t456.48
30-Jan-12\t453.01
27-Jan-12\t447.28
26-Jan-12\t444.63
25-Jan-12\t446.66
24-Jan-12\t420.41
23-Jan-12\t427.41
20-Jan-12\t420.30
19-Jan-12\t427.75
18-Jan-12\t429.11
17-Jan-12\t424.70
13-Jan-12\t419.81
12-Jan-12\t421.39
11-Jan-12\t422.55
10-Jan-12\t423.24
9-Jan-12\t421.73
6-Jan-12\t422.40
5-Jan-12\t418.03
4-Jan-12\t413.44
3-Jan-12\t411.23
30-Dec-11\t405.00
29-Dec-11\t405.12
28-Dec-11\t402.64
27-Dec-11\t406.53
23-Dec-11\t403.43
22-Dec-11\t398.55
21-Dec-11\t396.44
20-Dec-11\t395.95
19-Dec-11\t382.21
16-Dec-11\t381.02
15-Dec-11\t378.94
14-Dec-11\t380.19
13-Dec-11\t388.81
12-Dec-11\t391.84
9-Dec-11\t393.62
8-Dec-11\t390.66
7-Dec-11\t389.09
6-Dec-11\t390.95
5-Dec-11\t393.01
2-Dec-11\t389.70
1-Dec-11\t387.93
30-Nov-11\t382.20
29-Nov-11\t373.20
28-Nov-11\t376.12
25-Nov-11\t363.57
23-Nov-11\t366.99
22-Nov-11\t376.51
21-Nov-11\t369.01
18-Nov-11\t374.94
17-Nov-11\t377.41
16-Nov-11\t384.77
15-Nov-11\t388.83
14-Nov-11\t379.26
11-Nov-11\t384.62
10-Nov-11\t385.22
9-Nov-11\t395.28
8-Nov-11\t406.23
7-Nov-11\t399.73
4-Nov-11\t400.24
3-Nov-11\t403.07
2-Nov-11\t397.41
1-Nov-11\t396.51
31-Oct-11\t404.78
28-Oct-11\t404.95
27-Oct-11\t404.69
26-Oct-11\t400.60
25-Oct-11\t397.77
24-Oct-11\t405.77
21-Oct-11\t392.87
20-Oct-11\t395.31
19-Oct-11\t398.62
18-Oct-11\t422.24
17-Oct-11\t419.99
14-Oct-11\t422.00
13-Oct-11\t408.43
12-Oct-11\t402.19
11-Oct-11\t400.29
10-Oct-11\t388.81
7-Oct-11\t369.80
6-Oct-11\t377.37
5-Oct-11\t378.25
4-Oct-11\t372.50
3-Oct-11\t374.60
30-Sep-11\t381.32
29-Sep-11\t390.57
28-Sep-11\t397.01
27-Sep-11\t399.26
26-Sep-11\t403.17
23-Sep-11\t404.30
22-Sep-11\t401.82
21-Sep-11\t412.14
20-Sep-11\t413.45
19-Sep-11\t411.63
16-Sep-11\t400.50
15-Sep-11\t392.96
14-Sep-11\t389.30
13-Sep-11\t384.62
12-Sep-11\t379.94
9-Sep-11\t377.48
8-Sep-11\t384.14
7-Sep-11\t383.93
6-Sep-11\t379.74
2-Sep-11\t374.05
1-Sep-11\t381.03
31-Aug-11\t384.83
30-Aug-11\t389.99
29-Aug-11\t389.97
26-Aug-11\t383.58
25-Aug-11\t373.72
24-Aug-11\t376.18
23-Aug-11\t373.60
22-Aug-11\t356.44
19-Aug-11\t356.03
18-Aug-11\t366.05
17-Aug-11\t380.44
16-Aug-11\t380.48
15-Aug-11\t383.41
12-Aug-11\t376.99
11-Aug-11\t373.70
10-Aug-11\t363.69
9-Aug-11\t374.01
8-Aug-11\t353.21
5-Aug-11\t373.62
4-Aug-11\t377.37
3-Aug-11\t392.57
2-Aug-11\t388.91
1-Aug-11\t396.75
29-Jul-11\t390.48
28-Jul-11\t391.82
27-Jul-11\t392.59
26-Jul-11\t403.41
25-Jul-11\t398.50
22-Jul-11\t393.30
21-Jul-11\t387.29
20-Jul-11\t386.90
19-Jul-11\t376.85
18-Jul-11\t373.80
15-Jul-11\t364.92
14-Jul-11\t357.77
13-Jul-11\t358.02
12-Jul-11\t353.75
11-Jul-11\t354.00
8-Jul-11\t359.71
7-Jul-11\t357.20
6-Jul-11\t351.76
5-Jul-11\t349.43
1-Jul-11\t343.26
30-Jun-11\t335.67
29-Jun-11\t334.04
28-Jun-11\t335.26
27-Jun-11\t332.04
24-Jun-11\t326.35
23-Jun-11\t331.23
22-Jun-11\t322.61
21-Jun-11\t325.30
20-Jun-11\t315.32
17-Jun-11\t320.26
16-Jun-11\t325.16
15-Jun-11\t326.75
14-Jun-11\t332.44
13-Jun-11\t326.60
10-Jun-11\t325.90
9-Jun-11\t331.49
8-Jun-11\t332.24
7-Jun-11\t332.04
6-Jun-11\t338.04
3-Jun-11\t343.44
2-Jun-11\t346.10
1-Jun-11\t345.51
31-May-11\t347.83
27-May-11\t337.41
26-May-11\t335.00
25-May-11\t336.78
24-May-11\t332.19
23-May-11\t334.40
20-May-11\t335.22
19-May-11\t340.53
18-May-11\t339.87
17-May-11\t336.14
16-May-11\t333.30
13-May-11\t340.50
12-May-11\t346.57
11-May-11\t347.23
10-May-11\t349.45
9-May-11\t347.60
6-May-11\t346.66
5-May-11\t346.75
4-May-11\t349.57
3-May-11\t348.20
2-May-11\t346.28
29-Apr-11\t350.13
28-Apr-11\t346.75
27-Apr-11\t350.15
26-Apr-11\t350.42
25-Apr-11\t353.01
21-Apr-11\t350.70
20-Apr-11\t342.41
19-Apr-11\t337.86
18-Apr-11\t331.85
15-Apr-11\t327.46
14-Apr-11\t332.42
13-Apr-11\t336.13
12-Apr-11\t332.40
11-Apr-11\t330.80
8-Apr-11\t335.06
7-Apr-11\t338.08
6-Apr-11\t338.04
5-Apr-11\t338.89
4-Apr-11\t341.19
1-Apr-11\t344.56
31-Mar-11\t348.51
30-Mar-11\t348.63
29-Mar-11\t350.96
28-Mar-11\t350.44
25-Mar-11\t351.54
24-Mar-11\t344.97
23-Mar-11\t339.19
22-Mar-11\t341.20
21-Mar-11\t339.30
18-Mar-11\t330.67
17-Mar-11\t334.64
16-Mar-11\t330.01
15-Mar-11\t345.43
14-Mar-11\t353.56
11-Mar-11\t351.99
10-Mar-11\t346.67
9-Mar-11\t352.47
8-Mar-11\t355.76
7-Mar-11\t355.36
4-Mar-11\t360.00
3-Mar-11\t359.56
2-Mar-11\t352.12
1-Mar-11\t349.31
28-Feb-11\t353.21
25-Feb-11\t348.16
24-Feb-11\t342.88
23-Feb-11\t342.62
22-Feb-11\t338.61
18-Feb-11\t350.56
17-Feb-11\t358.30
16-Feb-11\t363.13
15-Feb-11\t359.90
14-Feb-11\t359.18
11-Feb-11\t356.85
10-Feb-11\t354.54
9-Feb-11\t358.16
8-Feb-11\t355.20
7-Feb-11\t351.88
4-Feb-11\t346.50
3-Feb-11\t343.44
2-Feb-11\t344.32
1-Feb-11\t345.03
31-Jan-11\t339.32
28-Jan-11\t336.10
27-Jan-11\t343.21
26-Jan-11\t343.85
25-Jan-11\t341.40
24-Jan-11\t337.45
21-Jan-11\t326.72
20-Jan-11\t332.68
19-Jan-11\t338.84
18-Jan-11\t340.65
14-Jan-11\t348.48
13-Jan-11\t345.68
12-Jan-11\t344.42
11-Jan-11\t341.64
10-Jan-11\t342.46
7-Jan-11\t336.12
6-Jan-11\t333.73
5-Jan-11\t334.00
4-Jan-11\t331.29
3-Jan-11\t329.57
31-Dec-10\t322.56
30-Dec-10\t323.66
29-Dec-10\t325.29
28-Dec-10\t325.47
27-Dec-10\t324.68
23-Dec-10\t323.60
22-Dec-10\t325.16
21-Dec-10\t324.20
20-Dec-10\t322.21
17-Dec-10\t320.61
16-Dec-10\t321.25
15-Dec-10\t320.36
14-Dec-10\t320.29
13-Dec-10\t321.67
10-Dec-10\t320.56
9-Dec-10\t319.76
8-Dec-10\t321.01
7-Dec-10\t318.21
6-Dec-10\t320.15
3-Dec-10\t317.44
2-Dec-10\t318.15
1-Dec-10\t316.40
30-Nov-10\t311.15
29-Nov-10\t316.87
26-Nov-10\t315.00
24-Nov-10\t314.80
23-Nov-10\t308.73
22-Nov-10\t313.36
19-Nov-10\t306.73
18-Nov-10\t308.43
17-Nov-10\t300.50
16-Nov-10\t301.59
15-Nov-10\t307.04
12-Nov-10\t308.03
11-Nov-10\t316.66
10-Nov-10\t318.03
9-Nov-10\t316.08
8-Nov-10\t318.62
5-Nov-10\t317.13
4-Nov-10\t318.27
3-Nov-10\t312.80
2-Nov-10\t309.36
1-Nov-10\t304.18
29-Oct-10\t300.98
28-Oct-10\t305.24
27-Oct-10\t307.83
26-Oct-10\t308.05
25-Oct-10\t308.84
22-Oct-10\t307.47
21-Oct-10\t309.52
20-Oct-10\t310.53
19-Oct-10\t309.49
18-Oct-10\t318.00
15-Oct-10\t314.74
14-Oct-10\t302.31
13-Oct-10\t300.14
12-Oct-10\t298.54
11-Oct-10\t295.36
8-Oct-10\t294.07
7-Oct-10\t289.22
6-Oct-10\t289.19
5-Oct-10\t288.94
4-Oct-10\t278.64
1-Oct-10\t282.52
30-Sep-10\t283.75
29-Sep-10\t287.37
28-Sep-10\t286.86
27-Sep-10\t291.16
24-Sep-10\t292.32
23-Sep-10\t288.92
22-Sep-10\t287.75
21-Sep-10\t283.77
20-Sep-10\t283.23
17-Sep-10\t275.37
16-Sep-10\t276.57
15-Sep-10\t270.22
14-Sep-10\t268.06
13-Sep-10\t267.04
10-Sep-10\t263.41
9-Sep-10\t263.07
8-Sep-10\t262.92
7-Sep-10\t257.81
6-Sep-10\t258.77
3-Sep-10\t258.77
2-Sep-10\t252.17
1-Sep-10\t250.33
31-Aug-10\t243.10
30-Aug-10\t242.50
27-Aug-10\t241.62
26-Aug-10\t240.28
25-Aug-10\t242.89
24-Aug-10\t239.93
23-Aug-10\t245.80
20-Aug-10\t249.64
19-Aug-10\t249.88
18-Aug-10\t253.07
17-Aug-10\t251.97
16-Aug-10\t247.64
13-Aug-10\t249.10
12-Aug-10\t251.79
11-Aug-10\t250.19
10-Aug-10\t259.41
9-Aug-10\t261.75
6-Aug-10\t260.09
5-Aug-10\t261.70
4-Aug-10\t262.98
3-Aug-10\t261.93
2-Aug-10\t261.85
30-Jul-10\t257.25
29-Jul-10\t258.11
28-Jul-10\t260.96
27-Jul-10\t264.08
26-Jul-10\t259.28
23-Jul-10\t259.94
22-Jul-10\t259.02
21-Jul-10\t254.24
20-Jul-10\t251.89
19-Jul-10\t245.58
16-Jul-10\t249.90
15-Jul-10\t251.45
14-Jul-10\t252.73
13-Jul-10\t251.80
12-Jul-10\t257.28
9-Jul-10\t259.62
8-Jul-10\t258.09
7-Jul-10\t258.66
6-Jul-10\t248.63
5-Jul-10\t246.94
2-Jul-10\t246.94
1-Jul-10\t248.48
30-Jun-10\t251.53
29-Jun-10\t256.17
28-Jun-10\t268.30
25-Jun-10\t266.70
24-Jun-10\t269.00
23-Jun-10\t270.97
22-Jun-10\t273.85
21-Jun-10\t270.17
18-Jun-10\t274.07
17-Jun-10\t271.87
16-Jun-10\t267.25
15-Jun-10\t259.69
14-Jun-10\t254.28
11-Jun-10\t253.51
10-Jun-10\t250.51
9-Jun-10\t243.20
8-Jun-10\t249.33
7-Jun-10\t250.94
4-Jun-10\t255.96
3-Jun-10\t263.12
2-Jun-10\t263.95
1-Jun-10\t260.83
31-May-10\t256.88
28-May-10\t256.88
27-May-10\t253.35
26-May-10\t244.11
25-May-10\t245.22
24-May-10\t246.76
21-May-10\t242.32
20-May-10\t237.76
19-May-10\t248.34
18-May-10\t252.36
17-May-10\t254.22
14-May-10\t253.82
13-May-10\t258.36
12-May-10\t262.09
11-May-10\t256.52
10-May-10\t253.99
7-May-10\t235.86
6-May-10\t246.25
5-May-10\t255.98
4-May-10\t258.68
3-May-10\t266.35
30-Apr-10\t261.09
29-Apr-10\t268.64
28-Apr-10\t261.60
27-Apr-10\t262.04
26-Apr-10\t269.50
23-Apr-10\t270.83
22-Apr-10\t266.47
21-Apr-10\t259.22
20-Apr-10\t244.59
19-Apr-10\t247.07
16-Apr-10\t247.40
15-Apr-10\t248.92
14-Apr-10\t245.69
13-Apr-10\t242.43
12-Apr-10\t242.29
9-Apr-10\t241.79
8-Apr-10\t239.95
7-Apr-10\t240.60
6-Apr-10\t239.54
5-Apr-10\t238.49
2-Apr-10\t235.97
1-Apr-10\t235.97
31-Mar-10\t235.00
30-Mar-10\t235.84
29-Mar-10\t232.39
26-Mar-10\t230.90
25-Mar-10\t226.65
24-Mar-10\t229.37
23-Mar-10\t228.36
22-Mar-10\t224.75
19-Mar-10\t222.25
18-Mar-10\t224.65
17-Mar-10\t224.12
16-Mar-10\t224.45
15-Mar-10\t223.84
12-Mar-10\t226.60
11-Mar-10\t225.50
10-Mar-10\t224.84
9-Mar-10\t223.02
8-Mar-10\t219.08
5-Mar-10\t218.95
4-Mar-10\t210.71
3-Mar-10\t209.33
2-Mar-10\t208.85
1-Mar-10\t208.99
26-Feb-10\t204.62
25-Feb-10\t202.00
24-Feb-10\t200.66
23-Feb-10\t197.06
22-Feb-10\t200.42
19-Feb-10\t201.67
18-Feb-10\t202.93
17-Feb-10\t202.55
16-Feb-10\t203.40
15-Feb-10\t200.38
12-Feb-10\t200.38
11-Feb-10\t198.67
10-Feb-10\t195.12
9-Feb-10\t196.19
8-Feb-10\t194.12
5-Feb-10\t195.46
4-Feb-10\t192.05
3-Feb-10\t199.23
2-Feb-10\t195.86
1-Feb-10\t194.73
29-Jan-10\t192.06
28-Jan-10\t199.29
27-Jan-10\t207.88
26-Jan-10\t205.94
25-Jan-10\t203.08
22-Jan-10\t197.75
21-Jan-10\t208.07
20-Jan-10\t211.72
19-Jan-10\t215.04
18-Jan-10\t205.93
15-Jan-10\t205.93
14-Jan-10\t209.43
13-Jan-10\t210.65
12-Jan-10\t207.72
11-Jan-10\t210.11
8-Jan-10\t211.98
7-Jan-10\t210.58
6-Jan-10\t210.97
5-Jan-10\t214.38
4-Jan-10\t214.01
1-Jan-10\t210.73
31-Dec-09\t210.73
30-Dec-09\t211.64
29-Dec-09\t209.10
28-Dec-09\t211.61
25-Dec-09\t209.04
24-Dec-09\t209.04
23-Dec-09\t202.10
22-Dec-09\t200.36
21-Dec-09\t198.23
18-Dec-09\t195.43
17-Dec-09\t191.86
16-Dec-09\t195.03
15-Dec-09\t194.17
14-Dec-09\t196.98
11-Dec-09\t194.67
10-Dec-09\t196.43
9-Dec-09\t197.80
8-Dec-09\t189.87
7-Dec-09\t188.95
4-Dec-09\t193.32
3-Dec-09\t196.48
2-Dec-09\t196.23
1-Dec-09\t196.97
30-Nov-09\t199.91
27-Nov-09\t200.59
26-Nov-09\t204.19
25-Nov-09\t204.19
24-Nov-09\t204.44
23-Nov-09\t205.88
20-Nov-09\t199.92
19-Nov-09\t200.51
18-Nov-09\t205.96
17-Nov-09\t207.00
16-Nov-09\t206.63
13-Nov-09\t204.45
12-Nov-09\t201.99
11-Nov-09\t203.25
10-Nov-09\t202.98
9-Nov-09\t201.46
6-Nov-09\t194.34
5-Nov-09\t194.03
4-Nov-09\t190.81
3-Nov-09\t188.75
2-Nov-09\t189.31
30-Oct-09\t188.50
29-Oct-09\t196.35
28-Oct-09\t192.40
27-Oct-09\t197.37
26-Oct-09\t202.48
23-Oct-09\t203.94
22-Oct-09\t205.20
21-Oct-09\t204.92
20-Oct-09\t198.76
19-Oct-09\t189.86
16-Oct-09\t188.05
15-Oct-09\t190.56
14-Oct-09\t191.29
13-Oct-09\t190.02
12-Oct-09\t190.81
9-Oct-09\t190.47
8-Oct-09\t189.27
7-Oct-09\t190.25
6-Oct-09\t190.01
5-Oct-09\t186.02
2-Oct-09\t184.90
1-Oct-09\t180.86
30-Sep-09\t185.35
29-Sep-09\t185.38
28-Sep-09\t186.15
25-Sep-09\t182.37
24-Sep-09\t183.82
23-Sep-09\t185.50
22-Sep-09\t184.48
21-Sep-09\t184.02
18-Sep-09\t185.02
17-Sep-09\t184.55
16-Sep-09\t181.87
15-Sep-09\t175.16
14-Sep-09\t173.72
11-Sep-09\t172.16
10-Sep-09\t172.56
9-Sep-09\t171.14
8-Sep-09\t172.93
4-Sep-09\t170.31
3-Sep-09\t166.55
2-Sep-09\t165.18
1-Sep-09\t165.30
31-Aug-09\t168.21
28-Aug-09\t170.05
27-Aug-09\t169.45
26-Aug-09\t167.41
25-Aug-09\t169.40
24-Aug-09\t169.06
21-Aug-09\t169.22
20-Aug-09\t166.33
19-Aug-09\t164.60
18-Aug-09\t164.00
17-Aug-09\t159.59
14-Aug-09\t166.78
13-Aug-09\t168.42
12-Aug-09\t165.31
10-Aug-09\t164.72
7-Aug-09\t165.51
6-Aug-09\t163.91
5-Aug-09\t165.11
4-Aug-09\t165.55
3-Aug-09\t166.43
31-Jul-09\t163.39
30-Jul-09\t162.79
29-Jul-09\t160.03
28-Jul-09\t160.00
27-Jul-09\t160.10
24-Jul-09\t159.99
23-Jul-09\t157.82
22-Jul-09\t156.74
21-Jul-09\t151.51
20-Jul-09\t152.91
17-Jul-09\t151.75
16-Jul-09\t147.52
15-Jul-09\t146.88
14-Jul-09\t142.27
13-Jul-09\t142.34
10-Jul-09\t138.52
9-Jul-09\t136.36
8-Jul-09\t137.22
7-Jul-09\t135.40
6-Jul-09\t138.61
3-Jul-09\t140.02
2-Jul-09\t140.02
1-Jul-09\t142.83
30-Jun-09\t142.43
29-Jun-09\t141.97
26-Jun-09\t142.44
25-Jun-09\t139.86
24-Jun-09\t136.22
23-Jun-09\t134.01
22-Jun-09\t137.37
19-Jun-09\t139.48
18-Jun-09\t135.88
17-Jun-09\t135.58
16-Jun-09\t136.35
15-Jun-09\t136.09
12-Jun-09\t136.97
11-Jun-09\t139.95
10-Jun-09\t140.25
9-Jun-09\t142.72
8-Jun-09\t143.85
5-Jun-09\t144.67
4-Jun-09\t143.74
3-Jun-09\t140.95
2-Jun-09\t139.49
1-Jun-09\t139.35
29-May-09\t135.81
28-May-09\t135.07
27-May-09\t133.05
26-May-09\t130.78
22-May-09\t122.50
21-May-09\t124.18
20-May-09\t125.87
19-May-09\t127.45
18-May-09\t126.65
15-May-09\t122.42
14-May-09\t122.95
13-May-09\t119.49
12-May-09\t124.42
11-May-09\t129.57
8-May-09\t129.19
7-May-09\t129.06
6-May-09\t132.50
5-May-09\t132.71
4-May-09\t132.07
1-May-09\t127.24
30-Apr-09\t125.83
29-Apr-09\t125.14
28-Apr-09\t123.90
27-Apr-09\t124.73
24-Apr-09\t123.90
23-Apr-09\t125.40
22-Apr-09\t121.51
21-Apr-09\t121.76
20-Apr-09\t120.50
17-Apr-09\t123.42
16-Apr-09\t121.45
15-Apr-09\t117.64
14-Apr-09\t118.31
13-Apr-09\t120.22
10-Apr-09\t119.57
9-Apr-09\t119.57
8-Apr-09\t116.32
7-Apr-09\t115.00
6-Apr-09\t118.45
3-Apr-09\t115.99
2-Apr-09\t112.71
1-Apr-09\t108.69
31-Mar-09\t105.12
30-Mar-09\t104.49
27-Mar-09\t106.85
26-Mar-09\t109.87
25-Mar-09\t106.49
24-Mar-09\t106.50
23-Mar-09\t107.66
20-Mar-09\t101.59
19-Mar-09\t101.62
18-Mar-09\t101.52
17-Mar-09\t99.66
16-Mar-09\t95.42
13-Mar-09\t95.93
12-Mar-09\t96.35
11-Mar-09\t92.68
10-Mar-09\t88.63
9-Mar-09\t83.11
6-Mar-09\t85.30
5-Mar-09\t88.84
4-Mar-09\t91.17
3-Mar-09\t88.37
2-Mar-09\t87.94
27-Feb-09\t89.31
26-Feb-09\t89.19
25-Feb-09\t91.16
24-Feb-09\t90.25
23-Feb-09\t86.95
20-Feb-09\t91.20
19-Feb-09\t90.64
18-Feb-09\t94.37
17-Feb-09\t94.53
13-Feb-09\t99.16
12-Feb-09\t99.27
11-Feb-09\t96.82
10-Feb-09\t97.83
9-Feb-09\t102.51
6-Feb-09\t99.72
5-Feb-09\t96.46
4-Feb-09\t93.55
3-Feb-09\t92.98
2-Feb-09\t91.51
30-Jan-09\t90.13
29-Jan-09\t93.00
28-Jan-09\t94.20
27-Jan-09\t90.73
26-Jan-09\t89.64
23-Jan-09\t88.36
22-Jan-09\t88.36
21-Jan-09\t82.83
20-Jan-09\t78.20
16-Jan-09\t82.33
15-Jan-09\t83.38
14-Jan-09\t85.33
13-Jan-09\t87.71
12-Jan-09\t88.66
9-Jan-09\t90.58
8-Jan-09\t92.70
7-Jan-09\t91.01
6-Jan-09\t93.02
5-Jan-09\t94.58
2-Jan-09\t90.75
1-Jan-09\t85.35
31-Dec-08\t85.35
30-Dec-08\t86.29
29-Dec-08\t86.61
26-Dec-08\t85.81
25-Dec-08\t85.04
24-Dec-08\t85.04
23-Dec-08\t86.38
22-Dec-08\t85.74
19-Dec-08\t90.00
18-Dec-08\t89.43
17-Dec-08\t89.16
16-Dec-08\t95.43
15-Dec-08\t94.75
12-Dec-08\t98.27
11-Dec-08\t95.00
10-Dec-08\t98.21
9-Dec-08\t100.06
8-Dec-08\t99.72
5-Dec-08\t94.00
4-Dec-08\t91.41
3-Dec-08\t95.90
2-Dec-08\t92.47
1-Dec-08\t88.93
28-Nov-08\t92.67
27-Nov-08\t95.00
26-Nov-08\t95.00
25-Nov-08\t90.80
24-Nov-08\t92.95
21-Nov-08\t82.58
20-Nov-08\t80.49
19-Nov-08\t86.29
18-Nov-08\t89.91
17-Nov-08\t88.14
14-Nov-08\t90.24
13-Nov-08\t96.44
12-Nov-08\t90.12
11-Nov-08\t94.77
10-Nov-08\t95.88
7-Nov-08\t98.24
6-Nov-08\t99.10
5-Nov-08\t103.30
4-Nov-08\t110.99
3-Nov-08\t106.96
31-Oct-08\t107.59
30-Oct-08\t111.04
29-Oct-08\t104.55
28-Oct-08\t99.91
27-Oct-08\t92.09
24-Oct-08\t96.38
23-Oct-08\t98.23
22-Oct-08\t96.87
21-Oct-08\t91.49
20-Oct-08\t98.44
17-Oct-08\t97.40
16-Oct-08\t101.89
15-Oct-08\t97.95
14-Oct-08\t104.08
13-Oct-08\t110.26
10-Oct-08\t96.80
9-Oct-08\t88.74
8-Oct-08\t89.79
7-Oct-08\t89.16
6-Oct-08\t98.14
3-Oct-08\t97.07
2-Oct-08\t100.10
1-Oct-08\t109.12
30-Sep-08\t113.66
29-Sep-08\t105.26
26-Sep-08\t128.24
25-Sep-08\t131.93
24-Sep-08\t128.71
23-Sep-08\t126.84
22-Sep-08\t131.05
19-Sep-08\t140.91
18-Sep-08\t134.09
17-Sep-08\t127.83
16-Sep-08\t139.88
15-Sep-08\t140.36
12-Sep-08\t148.94
11-Sep-08\t152.65
10-Sep-08\t151.61
9-Sep-08\t151.68
8-Sep-08\t157.92
5-Sep-08\t160.18
4-Sep-08\t161.22
3-Sep-08\t166.96
2-Sep-08\t166.19
29-Aug-08\t169.53
28-Aug-08\t173.74
27-Aug-08\t174.67
26-Aug-08\t173.64
25-Aug-08\t172.55
22-Aug-08\t176.79
21-Aug-08\t174.29
20-Aug-08\t175.84
19-Aug-08\t173.53
18-Aug-08\t175.39
15-Aug-08\t175.74
14-Aug-08\t179.32
13-Aug-08\t179.30
12-Aug-08\t176.73
11-Aug-08\t173.56
8-Aug-08\t169.55
7-Aug-08\t163.57
6-Aug-08\t164.19
5-Aug-08\t160.64
4-Aug-08\t153.23
1-Aug-08\t156.66
31-Jul-08\t158.95
30-Jul-08\t159.88
29-Jul-08\t157.08
28-Jul-08\t154.40
25-Jul-08\t162.12
24-Jul-08\t159.03
23-Jul-08\t166.26
22-Jul-08\t162.02
21-Jul-08\t166.29
18-Jul-08\t165.15
17-Jul-08\t171.81
16-Jul-08\t172.81
15-Jul-08\t169.64
14-Jul-08\t173.88
11-Jul-08\t172.58
10-Jul-08\t176.63
9-Jul-08\t174.25
8-Jul-08\t179.55
7-Jul-08\t175.16
3-Jul-08\t170.12
2-Jul-08\t168.18
1-Jul-08\t174.68
30-Jun-08\t167.44
27-Jun-08\t170.09
26-Jun-08\t168.26
25-Jun-08\t177.39
24-Jun-08\t173.25
23-Jun-08\t173.16
20-Jun-08\t175.27
19-Jun-08\t180.90
18-Jun-08\t178.75
17-Jun-08\t181.43
16-Jun-08\t176.84
13-Jun-08\t172.37
12-Jun-08\t173.26
11-Jun-08\t180.81
10-Jun-08\t185.64
9-Jun-08\t181.61
6-Jun-08\t185.64
5-Jun-08\t189.43
4-Jun-08\t185.19
3-Jun-08\t185.37
2-Jun-08\t186.10
30-May-08\t188.75
29-May-08\t186.69
28-May-08\t187.01
27-May-08\t186.43
23-May-08\t181.17
22-May-08\t177.05
21-May-08\t178.19
20-May-08\t185.90
19-May-08\t183.60
16-May-08\t187.62
15-May-08\t189.73
14-May-08\t186.26
13-May-08\t189.96
12-May-08\t188.16
9-May-08\t183.45
8-May-08\t185.06
7-May-08\t182.59
6-May-08\t186.66
5-May-08\t184.73
2-May-08\t180.94
1-May-08\t180.00
30-Apr-08\t173.95
29-Apr-08\t175.05
28-Apr-08\t172.24
25-Apr-08\t169.73
24-Apr-08\t168.94
23-Apr-08\t162.89
22-Apr-08\t160.20
21-Apr-08\t168.16
18-Apr-08\t161.04
17-Apr-08\t154.49
16-Apr-08\t153.70
15-Apr-08\t148.38
14-Apr-08\t147.78
11-Apr-08\t147.14
10-Apr-08\t154.55
9-Apr-08\t151.44
8-Apr-08\t152.84
7-Apr-08\t155.89
4-Apr-08\t153.08
3-Apr-08\t151.61
2-Apr-08\t147.49
1-Apr-08\t149.53
31-Mar-08\t143.50
28-Mar-08\t143.01
27-Mar-08\t140.25
26-Mar-08\t145.06
25-Mar-08\t140.98
24-Mar-08\t139.53
20-Mar-08\t133.27
19-Mar-08\t129.67
18-Mar-08\t132.82
17-Mar-08\t126.73
14-Mar-08\t126.61
13-Mar-08\t127.94
12-Mar-08\t126.03
11-Mar-08\t127.35
10-Mar-08\t119.69
7-Mar-08\t122.25
6-Mar-08\t120.93
5-Mar-08\t124.49
4-Mar-08\t124.62
3-Mar-08\t121.73
29-Feb-08\t125.02
28-Feb-08\t129.91
27-Feb-08\t122.96
26-Feb-08\t119.15
25-Feb-08\t119.74
22-Feb-08\t119.46
21-Feb-08\t121.54
20-Feb-08\t123.82
19-Feb-08\t122.18
15-Feb-08\t124.63
14-Feb-08\t127.46
13-Feb-08\t129.40
12-Feb-08\t124.86
11-Feb-08\t129.45
8-Feb-08\t125.48
7-Feb-08\t121.24
6-Feb-08\t122.00
5-Feb-08\t129.36
4-Feb-08\t131.65
1-Feb-08\t133.75
31-Jan-08\t135.36
30-Jan-08\t132.18
29-Jan-08\t131.54
28-Jan-08\t130.01
25-Jan-08\t130.01
24-Jan-08\t135.60
23-Jan-08\t139.07
22-Jan-08\t155.64
18-Jan-08\t161.36
17-Jan-08\t160.89
16-Jan-08\t159.64
15-Jan-08\t169.04
14-Jan-08\t178.78
11-Jan-08\t172.69
10-Jan-08\t178.02
9-Jan-08\t179.40
8-Jan-08\t171.25
7-Jan-08\t177.64
4-Jan-08\t180.05
3-Jan-08\t194.93
2-Jan-08\t194.84
31-Dec-07\t198.08
28-Dec-07\t199.83
27-Dec-07\t198.57
26-Dec-07\t198.95
24-Dec-07\t198.80
21-Dec-07\t193.91
20-Dec-07\t187.21
19-Dec-07\t183.12
18-Dec-07\t182.98
17-Dec-07\t184.40
14-Dec-07\t190.39
13-Dec-07\t191.83
12-Dec-07\t190.86
11-Dec-07\t188.54
10-Dec-07\t194.21
7-Dec-07\t194.30
6-Dec-07\t189.95
5-Dec-07\t185.50
4-Dec-07\t179.81
3-Dec-07\t178.86
30-Nov-07\t182.22
29-Nov-07\t184.29
28-Nov-07\t180.22
27-Nov-07\t174.81
26-Nov-07\t172.54
23-Nov-07\t171.54
21-Nov-07\t168.46
20-Nov-07\t168.85
19-Nov-07\t163.95
16-Nov-07\t166.39
15-Nov-07\t164.30
14-Nov-07\t166.11
13-Nov-07\t169.96
12-Nov-07\t153.76
9-Nov-07\t165.37
8-Nov-07\t175.47
7-Nov-07\t186.30
6-Nov-07\t191.79
5-Nov-07\t186.18
2-Nov-07\t187.87
1-Nov-07\t187.44
31-Oct-07\t189.95
30-Oct-07\t187.00
29-Oct-07\t185.09
26-Oct-07\t184.70
25-Oct-07\t182.78
24-Oct-07\t185.93
23-Oct-07\t186.16
22-Oct-07\t174.36
19-Oct-07\t170.42
18-Oct-07\t173.50
17-Oct-07\t172.75
16-Oct-07\t169.58
15-Oct-07\t166.98
12-Oct-07\t167.25
11-Oct-07\t162.23
10-Oct-07\t166.79
9-Oct-07\t167.86
8-Oct-07\t167.91
5-Oct-07\t161.45
4-Oct-07\t156.24
3-Oct-07\t157.92
2-Oct-07\t158.45
1-Oct-07\t156.34
28-Sep-07\t153.47
27-Sep-07\t154.50
26-Sep-07\t152.77
25-Sep-07\t153.18
24-Sep-07\t148.28
21-Sep-07\t144.15
20-Sep-07\t140.31
19-Sep-07\t140.77
18-Sep-07\t140.92
17-Sep-07\t138.41
14-Sep-07\t138.81
13-Sep-07\t137.20
12-Sep-07\t136.85
11-Sep-07\t135.49
10-Sep-07\t136.71
7-Sep-07\t131.77
6-Sep-07\t135.01
5-Sep-07\t136.76
4-Sep-07\t144.16
31-Aug-07\t138.48
30-Aug-07\t136.25
29-Aug-07\t134.08
28-Aug-07\t126.82
27-Aug-07\t132.25
24-Aug-07\t135.30
23-Aug-07\t131.07
22-Aug-07\t132.51
21-Aug-07\t127.57
20-Aug-07\t122.22
17-Aug-07\t122.06
16-Aug-07\t117.05
15-Aug-07\t119.90
14-Aug-07\t124.03
13-Aug-07\t127.79
10-Aug-07\t125.00
9-Aug-07\t126.39
8-Aug-07\t134.01
7-Aug-07\t135.03
6-Aug-07\t135.25
3-Aug-07\t131.85
2-Aug-07\t136.49
1-Aug-07\t135.00
31-Jul-07\t131.76
30-Jul-07\t141.43
27-Jul-07\t143.85
26-Jul-07\t146.00
25-Jul-07\t137.26
24-Jul-07\t134.89
23-Jul-07\t143.70
20-Jul-07\t143.75
19-Jul-07\t140.00
18-Jul-07\t138.12
17-Jul-07\t138.91
16-Jul-07\t138.10
13-Jul-07\t137.73
12-Jul-07\t134.07
11-Jul-07\t132.39
10-Jul-07\t132.35
9-Jul-07\t130.33
6-Jul-07\t132.30
5-Jul-07\t132.75
3-Jul-07\t127.17
2-Jul-07\t121.26
29-Jun-07\t122.04
28-Jun-07\t120.56
27-Jun-07\t121.89
26-Jun-07\t119.65
25-Jun-07\t122.34
22-Jun-07\t123.00
21-Jun-07\t123.90
20-Jun-07\t121.55
19-Jun-07\t123.66
18-Jun-07\t125.09
15-Jun-07\t120.50
14-Jun-07\t118.75
13-Jun-07\t117.50
12-Jun-07\t120.38
11-Jun-07\t120.19
8-Jun-07\t124.49
7-Jun-07\t124.07
6-Jun-07\t123.64
5-Jun-07\t122.67
4-Jun-07\t121.33
1-Jun-07\t118.40
31-May-07\t121.19
30-May-07\t118.77
29-May-07\t114.35
25-May-07\t113.62
24-May-07\t110.69
23-May-07\t112.89
22-May-07\t113.54
21-May-07\t111.98
18-May-07\t110.02
17-May-07\t109.44
16-May-07\t107.34
15-May-07\t107.52
14-May-07\t109.36
11-May-07\t108.74
10-May-07\t107.34
9-May-07\t106.88
8-May-07\t105.06
7-May-07\t103.92
4-May-07\t100.81
3-May-07\t100.40
2-May-07\t100.39
1-May-07\t99.47
30-Apr-07\t99.80
27-Apr-07\t99.92
26-Apr-07\t98.84
25-Apr-07\t95.35
24-Apr-07\t93.24
""".toString()
    def index() {
        render (view: 'cookin')
    }
    def nick() {
        render (view: 'nick')
    }
    def multi() {
        render (view: 'multi')
    }
    def arrayData() {
        render (view: 'arrayData')
    }

    def arrayNest() {
        render (view: 'arrayNest')
    }
    def simpleTest() {
        render (view: 'simpleTest')
    }
    def simpleTest2() {
        render (view: 'simpleTest2')
    }
    def layoutTest() {
        render (view: 'layoutTest')
    }
    def sliderTest() {
        render (view: 'sliderTest')
    }
    def colorPicker() {
        render (view: 'colorPicker')
    }
    def highlight() {
        render (view: 'highlight')
    }
    def brush() {
        render (view: 'brush')
    }
    def arrayFilter() {
        render (view: 'arrayFilter')
    }
    def colorinterp() {
        render (view: 'colorinterp')
    }
    def basicAxes() {
        render (view: 'basic-axes')
    }
    def gridLines() {
        render (view: 'grid-line')
    }
    def rescaling() {
        render (view: 'rescaling')
    }
    def multiElementTransition() {
        render (view: 'multi-element-transition')
    }
    def easing() {
        render (view: 'easing')
    }
    def tweening() {
        render (view: 'tweening')
    }
    def lineInt() {
        render (view: 'lineInt')
    }
    def areaChart() {
        render (view: 'area-chart')
    }
    def sbox() {
        render (view: 'sbox')
    }
    def scatterplotChart() {
        render (view: 'scatterplot-chart')
    }
    def bubbleChart() {
        render (view: 'bubble-chart')
    }
    def pieChart() {
        render (view: 'pie-chart')
    }
    def steepcurve() {
        render (view: 'steepcurve')
    }
    def poly() {
        render (view: 'poly')
    }
    def simpleHtml() {
        render (view: 'simpleHtml')
    }
    def simpleCss() {
        render (view: 'simpleCss')
    }
    def simpleJs() {
        render (view: 'simpleJs')
    }
    def mandelbrot() {
        render (view: 'mandelbrot')
    }
    def d3expts() {
        render (view: 'd3expts')
    }
    def histocruise() {
        render (view: 'histocruise')
    }
    def sierpinski() {
        render (view: 'sierpinski')
    }
    def runSTests() {
        render (view: 'runSTests')
    }
    def fundamental() {
        render (view: 'fundamental')
    }
    def simp() {
        render (view: 'simp')
    }
    def simp2() {
        render (view: 'simp2')
    }
    def simp3() {
        render (view: 'simp3')
    }
    def simp4() {
        render (view: 'simp4')
    }
    def heatmap() {
        render (view: 'heatmap')
    }
    def layout() {
        render (view: 'layout')
    }
    def windmill() {
        render (view: 'windmill')
    }
    def mbar() {
        render (view: 'mbar')
    }



    def histogramData = """
[
    { "key": 0, "value": 5 },
    { "key": 1, "value": 10 },
    { "key": 2, "value": 13 },
    { "key": 3, "value": 20 },
    { "key": 4, "value": 22 },
    { "key": 5, "value": 26 },
    { "key": 6, "value": 22 },
    { "key": 7, "value": 19 },
    { "key": 8, "value": 18 },
    { "key": 9, "value": 13 },
    { "key": 10, "value": 11 },
    { "key": 11, "value": 12 },
    { "key": 12, "value": 15 },
    { "key": 13, "value": 16 },
    { "key": 14, "value": 17 }]"""

    def retrieveJson(){
        render(histogramData.toString()) ;
    }
    def retrieveFruit(){
        render(fruits) ;
    }
    def retrieveAapl(){
        render(aapl) ;
    }
    def serveVideo() {
        render (view: 'serveVideo')
    }
    def cookin(){}
}
