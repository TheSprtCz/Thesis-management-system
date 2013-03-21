package com.redhat.theses.listeners

import com.redhat.theses.Application
import com.redhat.theses.Feed
import com.redhat.theses.events.ApplicationEvent
import com.redhat.theses.util.Util
import grails.events.Listener

/**
 * @author vdedik@redhat.com
 */
class ApplicationListenerService {

    /**
     * Dependency injection of com.redhat.theses.SubscriptionService
     */
    def subscriptionService

    /**
     * Dependency injection of org.codehaus.groovy.grails.web.mapping.LinkGenerator
     */
    def grailsLinkGenerator

    @Listener(topic = "applicationCreated")
    def applicationCreated(ApplicationEvent e) {
        def application = Application.get(e.application.id)
        def args = [
                e.user.fullName,
                grailsLinkGenerator.link(controller: 'user', action: 'show', id: e.user.id, absolute: true),
                grailsLinkGenerator.link(controller: 'application', action: 'show', id: application.id, absolute: true),
                application.topic.title,
                grailsLinkGenerator.link(controller: 'topic', action: 'show', id: application.topicId,
                        params: [headline: Util.hyphenize(application.topic.title)], absolute: true)
        ]

        def feed = new Feed(messageCode: 'feed.application.created', args: args, user: e.user).save()

        subscriptionService.notify(application.topic.owner, feed, application.topic.title)
    }

    @Listener(topic = "applicationApproved")
    def applicationApproved(ApplicationEvent e) {
        def application = Application.get(e.application.id)
        def args = [
                e.user.fullName,
                grailsLinkGenerator.link(controller: 'user', action: 'show', id: e.user.id, absolute: true),
                grailsLinkGenerator.link(controller: 'application', action: 'show', id: application.id, absolute: true),
                application.topic.title,
                grailsLinkGenerator.link(controller: 'topic', action: 'show', id: application.topicId,
                        params: [headline: Util.hyphenize(application.topic.title)], absolute: true)
        ]

        def feed = new Feed(messageCode: 'feed.application.approved', args: args, user: e.user).save()

        subscriptionService.notify(application.applicant, feed, application.topic.title)
    }
}