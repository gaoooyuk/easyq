// Decision tree algorithm implementation in kdb+/q

/ GrowTree function
/ @param data(Table|List) training data
/ @param features (List) set of features

growTree: {
	[data; features];

	$[homogeneous data; :label data]; // if Homogeneous(D) then return Label(D)

	S: bestSplit data;features


};

homogeneous: {
	
};

label: {
	
};

bestSplit: {
	[data; features];
	impurity: 1;


};

split: {
	
}

imp: {
	[subset]
}

gini: {[p] 2 * p * (1 - p)}

entropy: {[p] ((0-p * 2 xlog p) - ((1-p) * 2 xlog (1-p))) % 2}

sqrtGini: {[p] sqrt p * (1-p)}





/ idx: til 10
/ length: 3 4 3 5 5 5 4 5 4 4
/ gills: 0 0 0 0 0 1 1 1 1 0
/ beak: 1 1 1 1 1 1 1 0 0 1
/ teeth: 1 1 0 1 0 1 1 1 1 0
/ label: 1 1 1 1 1 0 0 0 0 0
/ shark:([]idx;length;gills;beak;teeth;label)