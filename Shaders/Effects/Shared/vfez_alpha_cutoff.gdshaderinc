uniform float alpha_cuttof_value: hint_range(0.001, 1.) = 0.5;

float alpha_cutoff(float alpha)
{
	if (((1. - alpha_cuttof_value) - (1. - alpha) - 0.01) < 0.)
	{
		return 0.;
	}
	else
	{
		return alpha;
	}
}