  CREATE OR REPLACE FORCE VIEW VW_TASK_QUEUE_DASHBOARD ("QUEUE_OBJECT_DETAIL_ID", "QUEUE_ID", "QUEUE_NAME", "ASSIGNED_OBJECT_ID", "ASSIGNED_OBJECT_TYPE_ID", "ASSIGNMENT_STATUS_ENUM", "ASSIGNMENT_STATUS", "ASSIGNMENT_TYPE_ENUM", "ASSIGNMENT_TYPE", "TASK_TITLE", "TASK_CATEGORY", "TASK_SUB_CATEGORY", "TASK_CREATED_DATE", "TASK_DUE_DATE", "TASK_TIME_TO_COMPLETE", "TASK_ASSIGNED_TO_NAME", "TASK_STATUS", "QUEUE_OBJECT_ASGMT_ID", "ASSIGNED_DRAGON_USER_ID", "ASSIGNED_DRAGON_USER_NAME", "USER_ASSIGNMENT_DATE", "ASSIGNMENT_ACTION_ENUM", "ASSIGNMENT_ACTION_NAME", "TASK_LAST_UPD_DT", "TASK_OBJECT_NAME") AS 
  SELECT   Q.QUEUE_OBJECT_DETAIL_ID,
         Q.QUEUE_ID,
         Q.QUEUE_NAME,
         Q.ASSIGNED_OBJECT_ID,
         Q.ASSIGNED_OBJECT_TYPE_ID,
         Q.ASSIGNMENT_STATUS_ENUM,
         Q.ASSIGNMENT_STATUS,
         Q.ASSIGNMENT_TYPE_ENUM,
         Q.ASSIGNMENT_TYPE,
         T.TASK_TITLE,
         (SELECT TC.TASK_CATEGORY_NAME FROM TASK_CATEGORY TC WHERE T.TASK_CATEGORY=TC.TASK_CATEGORY_ID),
         (SELECT TSC.TASK_SUB_CATEGORY_NAME FROM TASK_SUB_CATEGORY TSC WHERE T.TASK_SUB_CATEGORY=TSC.TASK_SUB_CATEGORY_ID),
         T.TASK_CREATED_DATE,
         T.TASK_DUE_DATE,
         T.TASK_TIME_TO_COMPLETE,
         T.TASK_ASSIGNED_TO_NAME,
         T.TASK_STATUS,
         QOAD.QUEUE_OBJECT_ASGMT_ID,
         ASSIGNED_DRAGON_USER_ID,
         DECODE(QOAD.ASSIGNED_DRAGON_USER_NAME,'0','',QOAD.ASSIGNED_DRAGON_USER_NAME),
         QOAD.USER_ASSIGNMENT_DATE,
         QOAD.ASSIGNMENT_ACTION_ENUM,
         QOAD.ASSIGNMENT_ACTION_NAME,
         T.TASK_LAST_UPD_DT,
	     T.TASK_OBJECT_NAME
  FROM   QUEUE_OBJECT_DETAIL Q,
         DRAGON_RECENT_TASKS T ,
         QUEUE_OBJECT_ASGMT_DETAIL QOAD,
         DRAGON_QUEUE_DEFINITION DQD
  WHERE  Q.ASSIGNED_OBJECT_ID = T.TASK_ID  AND
         Q.QUEUE_OBJECT_DETAIL_ID = QOAD.QUEUE_OBJECT_DETAIL_ID(+) AND
         Q.QUEUE_ID=DQD.QUEUE_DEFINITION_ID AND
         DQD.ACTIVE_TF='1';
/ 
