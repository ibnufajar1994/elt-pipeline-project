import luigi
import logging
import pandas as pd
import time
import subprocess as sp
from datetime import datetime
from pipeline.load import Load
import os

# Define DIR
DIR_ROOT_PROJECT = os.getenv("DIR_ROOT_PROJECT")
DIR_TEMP_LOG = os.getenv("DIR_TEMP_LOG")
DIR_TEMP_DATA = os.getenv("DIR_TEMP_DATA")
DIR_DBT_TRANSFORM = os.getenv("DIR_DBT_TRANSFORM")
DIR_LOG = os.getenv("DIR_LOG")




class Transform(luigi.Task):

    def requires(self) -> None:
        return Load()



    def run(self) -> None:

        #----------------------------------------------------------------------------------------------------------------------------------------
        # Record start time for transform tables
        start_time = time.time()
        logging.info("==================================STARTING TRANSFROM DATA=======================================")  

        try:
            # Run dbt debug
            with open (file = f'{DIR_TEMP_LOG}/logs.log', mode = 'a') as f:
                p1 = sp.run(
                    f"cd {DIR_DBT_TRANSFORM} && dbt debug",
                    stdout=f,
                    stderr=sp.PIPE,
                    text=True,
                    shell=True,
                    check=True,
                )
                if p1.returncode == 0:
                    print("Success Run dbt debug process")
                else:
                    print("Failed to run dbt debug process")

            # Run dbt deps
            with open (file = f'{DIR_TEMP_LOG}/logs.log', mode = 'a') as f:
                p1 = sp.run(
                    f"cd {DIR_DBT_TRANSFORM} && dbt deps",
                    stdout=f,
                    stderr=sp.PIPE,
                    text=True,
                    shell=True,
                    check=True,
                )
                if p1.returncode == 0:
                    print("Success Run dbt deps process")
                else:
                    print("Failed to run dbt deps process")

            # Run dbt run
            with open (file = f'{DIR_TEMP_LOG}/logs.log', mode = 'a') as f:
                p1 = sp.run(
                    f"cd {DIR_DBT_TRANSFORM} && dbt run",
                    stdout=f,
                    stderr=sp.PIPE,
                    text=True,
                    shell=True,
                    check=True,
                )
                if p1.returncode == 0:
                    print("Success running dbt data model")
                else:
                    print("Failed to run dbt data model")

            # Run dbt test
            with open (file = f'{DIR_TEMP_LOG}/logs.log', mode = 'a') as f:
                p1 = sp.run(
                    f"cd {DIR_DBT_TRANSFORM} && dbt test",
                    stdout=f,
                    stderr=sp.PIPE,
                    text=True,
                    shell=True,
                    check=True,
                )
                if p1.returncode == 0:
                    print("Success running testing and create a constraints")
                else:
                    print("Failed running testing and create constraints")

                    # Record end time for transform all tables
            
            end_time = time.time()  
            execution_time = end_time - start_time  # Calculate execution time

            # Get summary
            summary_data = {
                'timestamp': [datetime.now()],
                'task': ['Transform'],
                'status' : ['Success'],
                'execution_time': [execution_time]
            }

            # Get summary dataframes
            summary = pd.DataFrame(summary_data)
            
            # Write Summary to CSV
            summary.to_csv(f"{DIR_TEMP_DATA}/transform-summary.csv", index = False)

        except Exception:
            logging.error(f"Transform to All Dimensions and Fact Tables - FAILED")
        
            # Get summary
            summary_data = {
                'timestamp': [datetime.now()],
                'task': ['Transform'],
                'status' : ['Failed'],
                'execution_time': [0]
            }

            # Get summary dataframes
            summary = pd.DataFrame(summary_data)
            
            # Write Summary to CSV
            summary.to_csv(f"{DIR_TEMP_DATA}/transform-summary.csv", index = False)
            
            logging.error("Transform Tables - FAILED")
            raise Exception('Failed Transforming Tables')   
        
        logging.info("==================================ENDING TRANSFROM DATA=======================================") 

    #----------------------------------------------------------------------------------------------------------------------------------------
    def output(self):
        return [luigi.LocalTarget(f'{DIR_TEMP_LOG}/logs.log'),
                luigi.LocalTarget(f'{DIR_TEMP_DATA}/transform-summary.csv')]
        

