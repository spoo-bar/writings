---
title: "Dynamically loading audio sources with Vue.js"
date: 2019-08-17T00:00:00+00:00
author: Spoorthi Satheesha
layout: post
permalink: /dynamically-loading-audio-sources-with-vuejs/
categories: Programming
tags: [typescript, vuejs]
excerpt: "Tutorial and guide to dynamically loading audio sources with Vue.js"
seo_title: "Dynamically loading audio sources with Vue.js"
seo_description: "Tutorial and guide to dynamically loading audio sources with Vue.js"
---


I was making a simple podcast player in Vue.js. It shows the details of the latest episode of the podcast like Title and Description. It shows an audio control to play the podcast within the same page. I am using the default HTML `<audio>` element to play the podcast episode.

On page load, podcast RSS feed is fetched and the episode related properties are populated. However, it takes a while to fetch the feed, until then the source for the `<audio>` element is #. Just binding the `<audio>` source to a Vue property does not update the source from # to the episode mp3 path. Once the binded property value is changed, the audio element needs to be reloaded explicitly. This can be done by adding a watcher to that property where we reload the `<audio>` element on the property value change.

```vue

<template>
  <div>
    <div class="card">
      <div class="card-body">
        <h4 class="card-title">{{ episodeTitle }}</h4>
        <br />
        <audio ref="player" controls>
          <source v-bind:src="episodeAudioSource" type="audio/mpeg" />
          Audio controls are not supported in this browser
        </audio>
        <br />
        <pre class="card-text">
          {{ episodeDescription }}
        </pre>
      </div>
    </div>    
  </div>
</template>

<script lang="ts">
import { Component, Watch, Vue } from 'vue-property-decorator';
@Component
export default class PodcastDetails extends Vue {
  private episodeTitle: string = '';
  private episodeDescription: string = '';
  private episodeAudioSource: string = '#';
  private readonly rss2jsonUrl: string = 'https://api.rss2json.com/v1/api.json?rss_url=';
  private readonly podcastFeedUrl: string = this.rss2jsonUrl + 'https://feeds.simplecast.com/mVuvbeQv';
  @Watch('episodeAudioSource')
  private onEpisodeAudioSourceChange(value: string, oldValue: string) {
    (this.$refs.player as Vue & { load: () => void }).load();
  }
  private mounted() {
    const xhttp = new XMLHttpRequest();
    xhttp.open('GET', this.podcastFeedUrl, true);
    const self = this;
    xhttp.onreadystatechange = function() {
      if (this.readyState === 4 && this.status === 200) {
        const data = JSON.parse(this.responseText);
        const latestEpisode = data.items[0];
        self.episodeTitle = latestEpisode.title;
        self.episodeDescription = latestEpisode.description;
        self.episodeAudioSource = latestEpisode.enclosure.link;
      }
    };
    xhttp.send();
  }
}
</script>

```