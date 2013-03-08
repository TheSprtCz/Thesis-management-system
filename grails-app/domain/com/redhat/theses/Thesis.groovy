package com.redhat.theses

import com.redhat.theses.auth.User

class Thesis extends Article{

    Topic topic
    User assignee
    User supervisor
    Status status
    Grade grade
    String thesisAbstract
    Date dateCreated

    static mapping = {
        thesisAbstract type: 'text'
        sort 'dateCreated'
        order 'desc'
    }

    static constraints = {
        grade nullable: true
        supervisor nullable: true
        thesisAbstract nullable: true

        topic validator: {topic ->
            topic?.id != null && Topic.get(topic.id)
        }

        assignee validator: {assignee ->
            assignee?.id != null && User.get(assignee.id)
        }
    }

    static bucketMapping = "thesis"

    public List<String> getFileURLs(){
       return null;
    }

}
