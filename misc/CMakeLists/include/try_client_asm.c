
//snd_mix.c
int*     snd_p;  
int      snd_linear_count;
short*   snd_out;

//snd_mixa.s
extern void S_WriteLinearBlastStereo16 (void);


int main() 
{
	S_WriteLinearBlastStereo16();
	return 0;
}
