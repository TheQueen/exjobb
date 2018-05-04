//PAPI collect TLB
#include <stdio.h>
#include <stdlib.h>
#include <papi.h>

int measureDTLBmissesPAPI(int pid)
{
	int retval, eventSet = PAPI_NULL;
	long_long value[1];
  value[0] = 0;

/********************init library************************/

	retval = PAPI_library_init(PAPI_VER_CURRENT);

	if(retval != PAPI_VER_CURRENT && retval > 0)
		printf("PAPI-error, libary mismatch\n");

  if(retval < 0)
		printf("PAPI-error, init error\n");

/*******************event setup**************************/

  if((retval = PAPI_create_eventset(&eventSet)) != PAPI_OK)
    printf("PAPI-error, setup create eventset: %s\n", PAPI_strerror(retval));

  if((retval = PAPI_add_event(eventSet, PAPI_TLB_DM)) != PAPI_OK)
    printf("PAPI-error, setup add event: %d\n", retval);

  if((retval = PAPI_attach(eventSet, pid)) != PAPI_OK)
    printf("PAPI-error, setup attach: %d\n", retval);

/******************run event*****************************/

  if((retval = PAPI_start(eventSet)) != PAPI_OK)
    printf("PAPI-error, run event start: %d\n", retval);

  if((retval = PAPI_reset(eventSet)) != PAPI_OK)
    printf("PAPI-error, run event reset: %d\n", retval);

  while (1)
  {
    usleep(1000000);
    break;
  }
  if((retval = PAPI_stop(eventSet, value)) != PAPI_OK)
    printf("PAPI-error, run event stop: %d\n", retval);

  if((retval = PAPI_read(eventSet, value)) != PAPI_OK)
    printf("PAPI-error, run event read: %d\n", retval);
    printf("VALUE: %lld\n", value[0]);
/*****************cleanup cleanup**********************/

if((retval = PAPI_cleanup_eventset(eventSet)) != PAPI_OK)
  printf("PAPI-error, cleanup: %d\n", retval);

    return value[0];
}
