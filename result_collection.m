result = zeros(25*41,3);
for i = 1:25
    for j = 1:41
        result(j + 41*(i-1),1) = 4*i;
        result(j + 41*(i-1),2) = (j-1)/40;
    end
end
height = [3479,
3544,
3599,
3645,
3681,
3706,
3715,
3699,
3653,
2208,
2089,
2029,
2010,
2022,
2063,
2131,
2222,
2327,
2392,
2159,
2039,
1960,
1896,
1841,
1793,
1750,
1713,
1684,
1674,
1930,
2166,
2211,
2208,
2180,
2138,
2090,
2037,
1984,
1931,
1878,
1828,
2688,
2773,
2125,
2172,
2220,
2264,
2308,
2353,
2408,
2504,
1953,
1868,
1844,
1840,
1848,
1872,
1919,
1995,
2047,
1982,
1899,
1824,
1754,
1689,
1629,
1574,
1528,
2024,
1989,
1928,
1860,
1791,
1724,
1659,
1599,
1543,
1491,
1443,
1400,
1370,
1779,
2393,
1974,
2039,
2099,
2153,
2201,
2242,
2275,
2299,
2297,
1990,
1922,
1906,
1902,
1905,
1912,
1926,
1956,
1992,
1956,
1878,
1799,
1721,
1646,
1576,
1513,
1463,
1858,
1778,
1699,
1624,
1555,
1491,
1433,
1382,
1341,
1644,
1577,
1517,
1461,
1410,
2238,
1933,
2005,
2071,
2129,
2180,
2223,
2258,
2279,
2258,
2003,
1990,
1972,
1954,
1954,
1966,
1979,
1993,
2006,
1965,
1884,
1797,
1711,
1628,
1552,
1483,
1433,
1727,
1642,
1564,
1492,
1428,
1371,
1630,
1557,
1490,
1430,
1375,
1328,
1533,
1473,
1833,
1911,
1988,
2057,
1769,
1815,
1858,
1898,
1937,
1973,
2002,
2012,
1782,
1750,
1758,
1896,
1996,
2027,
2031,
1982,
1897,
1803,
1709,
1620,
1538,
1465,
1730,
1638,
1554,
1478,
1411,
1352,
1554,
1482,
1418,
1360,
1312,
1474,
1414,
1360,
1314,
1813,
1898,
1977,
1754,
1808,
1857,
1901,
1939,
1972,
1996,
1996,
1850,
1810,
1790,
1775,
1769,
1799,
2008,
2044,
1994,
1909,
1810,
1709,
1615,
1528,
1453,
1666,
1575,
1493,
1420,
1357,
1525,
1452,
1387,
1330,
1472,
1409,
1352,
1483,
1422,
1367,
1801,
1888,
1722,
1784,
1842,
1893,
1938,
1977,
2007,
2026,
1977,
1884,
1867,
1854,
1838,
1821,
1809,
1822,
1906,
1991,
1920,
1817,
1711,
1611,
1522,
1444,
1618,
1529,
1449,
1379,
1524,
1448,
1381,
1323,
1440,
1377,
1321,
1427,
1368,
1316,
1410,
1793,
1882,
1743,
1810,
1869,
1922,
1968,
2007,
2038,
2053,
1958,
1923,
1918,
1911,
1897,
1879,
1858,
1840,
1819,
1751,
1928,
1824,
1713,
1609,
1517,
1438,
1581,
1493,
1416,
1350,
1464,
1392,
1330,
1431,
1366,
1311,
1398,
1340,
1424,
1366,
1315,
1786,
1691,
1762,
1830,
1686,
1734,
1780,
1824,
2063,
2077,
1957,
1957,
1784,
1743,
1746,
1927,
1906,
1879,
1842,
1765,
1672,
1831,
1715,
1608,
1513,
1433,
1552,
1465,
1390,
1494,
1417,
1350,
1439,
1371,
1314,
1388,
1329,
1400,
1342,
1408,
1352,
1781,
1702,
1777,
1665,
1720,
1770,
1815,
1856,
1893,
1929,
1964,
1845,
1800,
1780,
1760,
1747,
1945,
1919,
1873,
1790,
1688,
1598,
1716,
1607,
1510,
1429,
1528,
1443,
1370,
1454,
1381,
1460,
1388,
1326,
1392,
1331,
1392,
1333,
1389,
1333,
1384,
1777,
1713,
1790,
1692,
1750,
1802,
1848,
1888,
1923,
1951,
1971,
1861,
1842,
1828,
1808,
1783,
1768,
1954,
1906,
1816,
1707,
1605,
1718,
1606,
1508,
1427,
1509,
1425,
1503,
1422,
1352,
1416,
1348,
1407,
1342,
1395,
1335,
1383,
1326,
1369,
1412,
1773,
1722,
1654,
1717,
1777,
1830,
1877,
1917,
1951,
1976,
1972,
1891,
1883,
1873,
1855,
1829,
1797,
1804,
1936,
1842,
1727,
1618,
1720,
1605,
1506,
1425,
1492,
1409,
1474,
1396,
1454,
1380,
1432,
1363,
1410,
1346,
1387,
1329,
1366,
1402,
1345,
1770,
1730,
1672,
1739,
1800,
1854,
1901,
1942,
1976,
2000,
1967,
1921,
1919,
1745,
1897,
1872,
1838,
1801,
1962,
1886,
1746,
1632,
1538,
1605,
1504,
1573,
1478,
1397,
1450,
1374,
1421,
1351,
1393,
1329,
1365,
1401,
1339,
1371,
1401,
1343,
1370,
1768,
1738,
1689,
1758,
1682,
1733,
1779,
1822,
1998,
2021,
1964,
1949,
1795,
1775,
1752,
1750,
1875,
1830,
1784,
1889,
1764,
1645,
1543,
1604,
1503,
1560,
1466,
1387,
1429,
1357,
1394,
1431,
1360,
1393,
1330,
1357,
1384,
1410,
1349,
1372,
1393,
1766,
1744,
1704,
1774,
1707,
1759,
1805,
1846,
1885,
2040,
1967,
1852,
1829,
1813,
1790,
1762,
1911,
1862,
1800,
1910,
1781,
1657,
1551,
1604,
1502,
1549,
1456,
1496,
1412,
1446,
1371,
1400,
1428,
1359,
1383,
1405,
1342,
1362,
1381,
1398,
1342,
1764,
1750,
1718,
1670,
1729,
1782,
1829,
1870,
1906,
1940,
1974,
1874,
1862,
1849,
1929,
1798,
1765,
1894,
1824,
1732,
1796,
1669,
1559,
1604,
1501,
1539,
1447,
1479,
1397,
1424,
1353,
1374,
1396,
1416,
1349,
1366,
1382,
1396,
1409,
1350,
1362,
1763,
1755,
1730,
1689,
1750,
1804,
1851,
1892,
1928,
1958,
1982,
1899,
1892,
1750,
1864,
1834,
1793,
1924,
1850,
1748,
1811,
1679,
1566,
1603,
1500,
1531,
1439,
1464,
1384,
1405,
1424,
1353,
1368,
1383,
1397,
1408,
1345,
1356,
1365,
1373,
1381,
1761,
1759,
1741,
1707,
1768,
1823,
1871,
1912,
1947,
1976,
1988,
1923,
1794,
1772,
1748,
1868,
1825,
1783,
1876,
1768,
1658,
1689,
1573,
1603,
1499,
1523,
1432,
1451,
1468,
1388,
1402,
1415,
1425,
1356,
1365,
1373,
1380,
1386,
1391,
1395,
1398,
1760,
1763,
1751,
1723,
1785,
1734,
1782,
1930,
1966,
1994,
1990,
1945,
1821,
1803,
1779,
1749,
1857,
1802,
1901,
1787,
1669,
1698,
1580,
1603,
1498,
1516,
1426,
1439,
1451,
1374,
1383,
1391,
1398,
1404,
1408,
1411,
1413,
1351,
1354,
1415,
1414,
1759,
1767,
1760,
1737,
1701,
1754,
1801,
1845,
1982,
2010,
1990,
1866,
1848,
1834,
1811,
1777,
1887,
1828,
1924,
1807,
1682,
1707,
1586,
1603,
1498,
1510,
1421,
1429,
1436,
1442,
1367,
1371,
1375,
1377,
1379,
1379,
1379,
1378,
1377,
1375,
1373,
1758,
1770,
1680,
1750,
1719,
1772,
1820,
1862,
1998,
2025,
1992,
1885,
1874,
1863,
1842,
1808,
1766.
1854,
1781,
1826,
1696,
1715,
1592,
1603,
1497,
1504,
1509,
1420,
1423,
1425,
1426,
1425,
1423,
1421,
1417,
1413,
1409,
1404,
1399,
1393,
1388,
1834,
1773,
1691,
1762,
1735,
1790,
1838,
1880,
1917,
2039,
1997,
1905,
1795,
1770,
1746,
1837,
1791,
1881,
1799,
1844,
1709,
1723,
1597,
1603,
1497,
1499,
1499,
1412,
1411,
1410,
1408,
1404,
1400,
1395,
1390,
1384,
1378,
1372,
1419,
1410,
1402,
1829,
1776,
1701,
1690,
1750,
1805,
1854,
1896,
1933,
2052,
2004,
1925,
1815,
1797,
1771,
1747,
1818,
1905,
1819,
1861,
1722,
1603,
1602,
1602,
1496,
1494,
1491,
1986,
1401,
1397,
1391,
1386,
1379,
1373,
1366,
1415,
1405,
1395,
1386,
1426,
1415,
1826,
1779,
1711,
1703,
1765,
1820,
1869,
1911,
1948,
1980,
2011,
1943,
1839,
1823,
1798,
1763,
1844,
1786,
1840,
1731,
1735,
1611,
1607,
1602,
1496,
1490,
1483,
1474,
1465,
1455,
1444,
1433,
1422,
1411,
1399,
1388,
1377,
1418,
1405,
1392,
1427,
1822,
1781,
1719,
1715,
1778,
1834,
1883,
1925,
1962,
1993,
2018,
1879,
1861,
1848,
1825,
1789,
1870,
1805,
1861,
1744,
1747,
1619,
1612.
1602,
1495,
1486,
1476,
1464,
1452,
1440,
1427,
1414,
1402,
1389,
1377,
1417,
1402,
1388,
1423,
1407,
1393];
result(:,3) = height;
plt = figure();
scatter3(result(:,1),result(:,2),result(:,3),'.');
xlabel('Value of ratio');
ylabel('Mixing of ABC field into a purely Bessel field.');
zlabel('Number of steps before particle trajectory disconnects from the field line starting at the same point');