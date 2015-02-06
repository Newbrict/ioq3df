
//ftola.asm
extern long qftolsse(float f);
extern int qvmftolsse(void);
extern long qftolx87(float f);
extern int qvmftolx87(void);
//snapvector.asm
//TODO

int main() 
{
	int result_int;
	long result_long;

	qftolsse(1.1);
	result_int = qvmftolsse();
	result_long = qftolx87(2.2);
	result_int = qvmftolx87();
	return 0;
}
