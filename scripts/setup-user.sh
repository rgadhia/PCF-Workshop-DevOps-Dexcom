#!/bin/bash
export CFUSER=test

export PASSWORD=${PASSWORD:=paasword!}
export EMAILDOMAIN=${EMAILDOMAIN:=dexcom.com}
export CFORGPREFIX=${CFORGPREFIX:=dexcom-devops}  
export CFORG=${CFORG:=$CFORGPREFIX-$CFUSER}
export CFSPACE=development

#cf delete-user -f $CFUSER@$EMAILDOMAIN
cf create-user $CFUSER@$EMAILDOMAIN $PASSWORD || true
cf create-org $CFORG
cf set-org-role $CFUSER@$EMAILDOMAIN $CFORG OrgManager
cf set-quota $CFORG runaway
cf create-space $CFSPACE -o $CFORG
cf set-space-role $CFUSER@$EMAILDOMAIN $CFORG $CFSPACE SpaceDeveloper
cf set-space-role $CFUSER@$EMAILDOMAIN $CFORG $CFSPACE SpaceManager
cf set-space-role $CFUSER@$EMAILDOMAIN $CFORG $CFSPACE SpaceAuditor


