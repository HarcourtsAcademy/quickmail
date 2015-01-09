@ferpa @javascript
Feature: Verify Ferpa controls WRT groups

	Background:
	Given the following "courses" exist:
		|fullname|shortname|category|
		|Course One|C1|0|
	And the following "users" exist:
		|username|firstname|lastname|
		|t1|t1|Teacher|
		|t4|t4|Teacher|
		|s1|s1|Student|
		|s4|s4|Student|
		|t2|t2|Teacher|
		|s2|s2|Student|
		|t3|t3|Teacher|
		|s3|s3|Student|
		|t5|t5|Teacher|
		|s5|s5|Student|
	And the following "course enrolments" exist:
		| user | course | role |
		|t1|C1|teacher|
		|t4|C1|editingteacher|
		|s1|C1|student|
		|s4|C1|student|
		|t2|C1|teacher|
		|s2|C1|student|
		|t3|C1|teacher|
		|s3|C1|student|
		|t5|C1|teacher|
		|s5|C1|student|
	Given the following "groups" exist:
		| name | course | idnumber|
		|group1|C1|group1|
		|group2|C1|group2|
		|group3|C1|group3|
	Given the following "group members" exist:
		| user      | group  |
		|t1|group1|
		|t4|group1|
		|t4|group2|
		|t4|group3|
		|s1|group1|
		|s4|group1|
		|s4|group2|
		|t2|group2|
		|s2|group2|
		|t3|group3|
		|s3|group3|
	Given I log in as "t4"
            	And I follow "Course One"
            	And I turn editing mode on
            	When I add the "Quickmail" block
            	Then I should see "Compose New Email" in the "Quickmail" "block"
            	And I log out
	

	# Configuration details:
	# Students globally allowed to use Quickmail.
	# Globally enforcing separate groups always.
	# unrecognized setting for groupsCourse.
	# Students allowed to use Quickmail at the course level.

	Scenario: 1
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|Yes|
			|FERPA Mode|Always Separate Groups|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|Yes|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1)" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group2)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "s4 Student" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group3)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "s4 Student" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "There are no users in your group capable of being emailed."
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "There are no users in your group capable of being emailed."
		And I log out



	

	# Configuration details:
	# Students globally allowed to use Quickmail.
	# Globally enforcing separate groups always.
	# unrecognized setting for groupsCourse.
	# Students disallowed from using Quickmail at the course level.

	Scenario: 2
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|Yes|
			|FERPA Mode|Always Separate Groups|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|No|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "s4 Student" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "There are no users in your group capable of being emailed."
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out



	

	# Configuration details:
	# Students globally allowed to use Quickmail.
	# Globally repsecting course group mode.
	# 'No groups' set at course level.
	# Students allowed to use Quickmail at the course level.

	Scenario: 3
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|Yes|
			|FERPA Mode|Respect Course Mode|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		And I follow "Edit settings"
		And I expand all fieldsets
		And I set the following fields to these values:
			|Group mode|No groups|

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|Yes|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		And I log out



	

	# Configuration details:
	# Students globally allowed to use Quickmail.
	# Globally repsecting course group mode.
	# 'No groups' set at course level.
	# Students disallowed from using Quickmail at the course level.

	Scenario: 4
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|Yes|
			|FERPA Mode|Respect Course Mode|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		And I follow "Edit settings"
		And I expand all fieldsets
		And I set the following fields to these values:
			|Group mode|No groups|

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|No|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out



	

	# Configuration details:
	# Students globally allowed to use Quickmail.
	# Globally repsecting course group mode.
	# 'separate groups' set at the course level.
	# Students allowed to use Quickmail at the course level.

	Scenario: 5
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|Yes|
			|FERPA Mode|Respect Course Mode|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		And I follow "Edit settings"
		And I expand all fieldsets
		And I set the following fields to these values:
			|Group mode|Separate groups|

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|Yes|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1)" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group2)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "s4 Student" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group3)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "s4 Student" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "There are no users in your group capable of being emailed."
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "There are no users in your group capable of being emailed."
		And I log out



	

	# Configuration details:
	# Students globally allowed to use Quickmail.
	# Globally repsecting course group mode.
	# 'separate groups' set at the course level.
	# Students disallowed from using Quickmail at the course level.

	Scenario: 6
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|Yes|
			|FERPA Mode|Respect Course Mode|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		And I follow "Edit settings"
		And I expand all fieldsets
		And I set the following fields to these values:
			|Group mode|Separate groups|

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|No|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "s4 Student" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "There are no users in your group capable of being emailed."
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out



	

	# Configuration details:
	# Students globally allowed to use Quickmail.
	# Globally repsecting course group mode.
	# Groups set to 'visible' at the course level.
	# Students allowed to use Quickmail at the course level.

	Scenario: 7
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|Yes|
			|FERPA Mode|Respect Course Mode|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		And I follow "Edit settings"
		And I expand all fieldsets
		And I set the following fields to these values:
			|Group mode|Visible groups|

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|Yes|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		And I log out



	

	# Configuration details:
	# Students globally allowed to use Quickmail.
	# Globally repsecting course group mode.
	# Groups set to 'visible' at the course level.
	# Students disallowed from using Quickmail at the course level.

	Scenario: 8
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|Yes|
			|FERPA Mode|Respect Course Mode|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		And I follow "Edit settings"
		And I expand all fieldsets
		And I set the following fields to these values:
			|Group mode|Visible groups|

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|No|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out



	

	# Configuration details:
	# Students globally allowed to use Quickmail.
	# Globally ignoring groups
	# unrecognized setting for groupsCourse.
	# Students allowed to use Quickmail at the course level.

	Scenario: 9
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|Yes|
			|FERPA Mode|No Group Respect|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|Yes|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		And I log out



	

	# Configuration details:
	# Students globally allowed to use Quickmail.
	# Globally ignoring groups
	# unrecognized setting for groupsCourse.
	# Students disallowed from using Quickmail at the course level.

	Scenario: 10
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|Yes|
			|FERPA Mode|No Group Respect|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|No|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out



	

	# Configuration details:
	# Students globally disallowed from using Quickmail.
	# Globally enforcing separate groups always.
	# unrecognized setting for groupsCourse.
	# Students allowed to use Quickmail at the course level.

	Scenario: 11
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|No|
			|FERPA Mode|Always Separate Groups|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|Yes|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1)" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group2)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "s4 Student" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group3)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "s4 Student" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "There are no users in your group capable of being emailed."
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "There are no users in your group capable of being emailed."
		And I log out



	

	# Configuration details:
	# Students globally disallowed from using Quickmail.
	# Globally enforcing separate groups always.
	# unrecognized setting for groupsCourse.
	# Students disallowed from using Quickmail at the course level.

	Scenario: 12
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|No|
			|FERPA Mode|Always Separate Groups|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|No|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "s4 Student" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "There are no users in your group capable of being emailed."
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out



	

	# Configuration details:
	# Students globally disallowed from using Quickmail.
	# Globally repsecting course group mode.
	# 'No groups' set at course level.
	# Students allowed to use Quickmail at the course level.

	Scenario: 13
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|No|
			|FERPA Mode|Respect Course Mode|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		And I follow "Edit settings"
		And I expand all fieldsets
		And I set the following fields to these values:
			|Group mode|No groups|

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|Yes|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		And I log out



	

	# Configuration details:
	# Students globally disallowed from using Quickmail.
	# Globally repsecting course group mode.
	# 'No groups' set at course level.
	# Students disallowed from using Quickmail at the course level.

	Scenario: 14
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|No|
			|FERPA Mode|Respect Course Mode|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		And I follow "Edit settings"
		And I expand all fieldsets
		And I set the following fields to these values:
			|Group mode|No groups|

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|No|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out



	

	# Configuration details:
	# Students globally disallowed from using Quickmail.
	# Globally repsecting course group mode.
	# 'separate groups' set at the course level.
	# Students allowed to use Quickmail at the course level.

	Scenario: 15
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|No|
			|FERPA Mode|Respect Course Mode|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		And I follow "Edit settings"
		And I expand all fieldsets
		And I set the following fields to these values:
			|Group mode|Separate groups|

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|Yes|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1)" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group2)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "s4 Student" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group3)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "s4 Student" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "There are no users in your group capable of being emailed."
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "There are no users in your group capable of being emailed."
		And I log out



	

	# Configuration details:
	# Students globally disallowed from using Quickmail.
	# Globally repsecting course group mode.
	# 'separate groups' set at the course level.
	# Students disallowed from using Quickmail at the course level.

	Scenario: 16
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|No|
			|FERPA Mode|Respect Course Mode|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		And I follow "Edit settings"
		And I expand all fieldsets
		And I set the following fields to these values:
			|Group mode|Separate groups|

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|No|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "s4 Student" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "There are no users in your group capable of being emailed."
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out



	

	# Configuration details:
	# Students globally disallowed from using Quickmail.
	# Globally repsecting course group mode.
	# Groups set to 'visible' at the course level.
	# Students allowed to use Quickmail at the course level.

	Scenario: 17
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|No|
			|FERPA Mode|Respect Course Mode|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		And I follow "Edit settings"
		And I expand all fieldsets
		And I set the following fields to these values:
			|Group mode|Visible groups|

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|Yes|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		And I log out



	

	# Configuration details:
	# Students globally disallowed from using Quickmail.
	# Globally repsecting course group mode.
	# Groups set to 'visible' at the course level.
	# Students disallowed from using Quickmail at the course level.

	Scenario: 18
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|No|
			|FERPA Mode|Respect Course Mode|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		And I follow "Edit settings"
		And I expand all fieldsets
		And I set the following fields to these values:
			|Group mode|Visible groups|

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|No|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out



	

	# Configuration details:
	# Students globally disallowed from using Quickmail.
	# Globally ignoring groups
	# unrecognized setting for groupsCourse.
	# Students allowed to use Quickmail at the course level.

	Scenario: 19
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|No|
			|FERPA Mode|No Group Respect|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|Yes|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		And I log out



	

	# Configuration details:
	# Students globally disallowed from using Quickmail.
	# Globally ignoring groups
	# unrecognized setting for groupsCourse.
	# Students disallowed from using Quickmail at the course level.

	Scenario: 20
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|No|
			|FERPA Mode|No Group Respect|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"

		# NOTE: Editingteachers and Teachers are able to see all users in all roles - is this correct ?
		Then I set the following fields to these values:
			|Allow students to use Quickmail|No|
		And I press "Save changes"
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out



	

	# Configuration details:
	# Students globally PROHIBITED from using Quickmail.
	# Globally enforcing separate groups always.
	# unrecognized setting for groupsCourse.
	# unrecognized setting for allowStudentsCourse.

	Scenario: 21
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|Never|
			|FERPA Mode|Always Separate Groups|
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "s4 Student" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "There are no users in your group capable of being emailed."
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out



	

	# Configuration details:
	# Students globally PROHIBITED from using Quickmail.
	# Globally repsecting course group mode.
	# 'No groups' set at course level.
	# unrecognized setting for allowStudentsCourse.

	Scenario: 22
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|Never|
			|FERPA Mode|Respect Course Mode|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		And I follow "Edit settings"
		And I expand all fieldsets
		And I set the following fields to these values:
			|Group mode|No groups|
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out



	

	# Configuration details:
	# Students globally PROHIBITED from using Quickmail.
	# Globally repsecting course group mode.
	# 'separate groups' set at the course level.
	# unrecognized setting for allowStudentsCourse.

	Scenario: 23
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|Never|
			|FERPA Mode|Respect Course Mode|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		And I follow "Edit settings"
		And I expand all fieldsets
		And I set the following fields to these values:
			|Group mode|Separate groups|
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "t3 Teacher" in the "#from_users" "css_element"
		Then I should not see "s3 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should not see "t1 Teacher" in the "#from_users" "css_element"
		Then I should not see "s1 Student" in the "#from_users" "css_element"
		Then I should not see "s4 Student" in the "#from_users" "css_element"
		Then I should not see "t2 Teacher" in the "#from_users" "css_element"
		Then I should not see "s2 Student" in the "#from_users" "css_element"
		Then I should not see "t5 Teacher" in the "#from_users" "css_element"
		Then I should not see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "There are no users in your group capable of being emailed."
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out



	

	# Configuration details:
	# Students globally PROHIBITED from using Quickmail.
	# Globally repsecting course group mode.
	# Groups set to 'visible' at the course level.
	# unrecognized setting for allowStudentsCourse.

	Scenario: 24
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|Never|
			|FERPA Mode|Respect Course Mode|
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		And I follow "Edit settings"
		And I expand all fieldsets
		And I set the following fields to these values:
			|Group mode|Visible groups|
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "t5 Teacher (Not in a group)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher (group1)" in the "#from_users" "css_element"
		Then I should see "t4 Teacher (group1,group2,group3)" in the "#from_users" "css_element"
		Then I should see "s1 Student (group1)" in the "#from_users" "css_element"
		Then I should see "s4 Student (group1,group2)" in the "#from_users" "css_element"
		Then I should see "t2 Teacher (group2)" in the "#from_users" "css_element"
		Then I should see "s2 Student (group2)" in the "#from_users" "css_element"
		Then I should see "t3 Teacher (group3)" in the "#from_users" "css_element"
		Then I should see "s3 Student (group3)" in the "#from_users" "css_element"
		Then I should see "s5 Student (Not in a group)" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out



	

	# Configuration details:
	# Students globally PROHIBITED from using Quickmail.
	# Globally ignoring groups
	# unrecognized setting for groupsCourse.
	# unrecognized setting for allowStudentsCourse.

	Scenario: 25
		Given I log in as "admin"
		And I set the following administration settings values:
			|Allow students to use Quickmail|Never|
			|FERPA Mode|No Group Respect|
		And I log out

		Given I log in as "t1"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "t4"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s1"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "s4"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t2"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s2"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t3"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "t5 Teacher" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s3"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out

		Given I log in as "t5"
		And I follow "Course One"
		When I click on "Compose New Email" "link" in the "Quickmail" "block"
		Then I should see "t1 Teacher" in the "#from_users" "css_element"
		Then I should see "t4 Teacher" in the "#from_users" "css_element"
		Then I should see "s1 Student" in the "#from_users" "css_element"
		Then I should see "s4 Student" in the "#from_users" "css_element"
		Then I should see "t2 Teacher" in the "#from_users" "css_element"
		Then I should see "s2 Student" in the "#from_users" "css_element"
		Then I should see "t3 Teacher" in the "#from_users" "css_element"
		Then I should see "s3 Student" in the "#from_users" "css_element"
		Then I should see "s5 Student" in the "#from_users" "css_element"
		And I log out

		Given I log in as "s5"
		And I follow "Course One"
		Then I should not see "Quickmail"
		And I log out



