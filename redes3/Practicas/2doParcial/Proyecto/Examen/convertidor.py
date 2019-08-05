def convertir_a_numero(x):
	total_stars = 0
	if 'k' in x:
		if len(x) > 1:
			total_stars = float(x.replace('k', '')) * 1000 # convert k to a thousand
	elif 'M' in x:
		if len(x) > 1:
			total_stars = float(x.replace('M', '')) * 1000000 # convert M to a million
	elif 'B' in x:
		total_stars = float(x.replace('B', '')) * 1000000000 # convert B to a Billion
	else:
		total_stars = float(x) # Less than 1000

	return float(total_stars)