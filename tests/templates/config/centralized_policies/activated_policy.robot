*** Settings ***
Documentation   Verify Correct Centralized Policy is Activated
Suite Setup     Login SDWAN Manager
Suite Teardown  Run On Last Process   Logout SDWAN Manager
Default Tags    sdwan  config  activated_policy
Resource        ../../sdwan_common.resource

{% if sdwan.centralized_policies.activated_policy is defined %}
{% set activated_policy_name = sdwan.centralized_policies.activated_policy %}

*** Test Cases ***
Verify Centralized Policy {{ activated_policy_name }} Activated
    ${r}=   GET On Session   sdwan_manager   /dataservice/template/policy/vsmart/
    Should Be Equal Value Json String   ${r.json()}   $..data[?(@..policyName=="{{ activated_policy_name }}")].isPolicyActivated   True   msg=Activated policy status

{% endif %}
