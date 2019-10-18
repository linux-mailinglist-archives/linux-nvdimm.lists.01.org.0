Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1BEDD08A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 22:41:05 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CA4C010FCB90B;
	Fri, 18 Oct 2019 13:43:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8CF3810FCB908
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 13:43:07 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c10so6057366otd.9
        for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 13:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wTpLreoG9rLELEy8Ih148Jhw0TAU572kXztmKOROW4=;
        b=EjZE5HAP18SrRyyODvTTxkpn9p9W1pthCZ6cfgSzvN1XVMjI+IGX4v4+ZGO0v8Fk+c
         L7zgWizkTXYfikohqpMXZR4T/ASOGzVCsosMFu6qYCsOmwsbkMw7szZsZLiPahSUTjR6
         IGtIqW1TpNohRpIw9prIIJEF2Qsb0jDqgVkluBVCvtYlNZvcpyURNw8hEBg0JO3QtZ0/
         eQRnLy3+lpmy8HNKq/F0nuOQjq9CTRqPz9w8dci09fzrNl5AfQZfjKSvV9XEpis1yHx0
         Yk8TYm79sGxwq2P/QKricMO26LkMQ8J9V1IIJUOdfGyCleJ8zxuiMCZaF74V3wwLfzjS
         ut0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wTpLreoG9rLELEy8Ih148Jhw0TAU572kXztmKOROW4=;
        b=kwhFXeqgicHHSSyz/F1xrt/RD4UW4boGPhlFW0rE8dwHfFZGP76350ZpM86h2FwWBv
         GOHmVsD+Kv3Xj5o5rmqOCHcS25ErWGhbOKaASw8Jp/qkDtv+1f/alp6UsJjpAaR6iFX3
         ZKEe5IJDESp2GxJA8ZbYgf9lIUwOJn9pZDDf8LtSK0pprI2bA1/aCgjHIkBVnolxCW6E
         ko8a/FWBIuE8nKXarNdwBqBUBu5Wdn7I9GP10qD62U6F5QkMXLWoE5Bb6VexqWYfmypK
         PGjfXl7oxfYeZJeanIC0X9rF2lEfp174m34Fsixgg1HMKtsn5xQ2s2G0Uve9+DrVi8p6
         urLA==
X-Gm-Message-State: APjAAAWl81zrFRUFQG7/1ItDrrDOGzyrUBh251bSPaDCybjNXzxStJ3N
	EGui0r+/uebcd3SNGlPcI/34fk42dKvbZMYjYlKBmA==
X-Google-Smtp-Source: APXvYqwAZnt4YV/RkmWW90bBf8cba69TXLNT8wp9eIyoK7mBoVabGRM4myAeaHB3Q6tUa3tz7/IyuBS36HdCMGS7O7U=
X-Received: by 2002:a05:6830:15ca:: with SMTP id j10mr1609084otr.247.1571431259692;
 Fri, 18 Oct 2019 13:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191002234925.9190-1-vishal.l.verma@intel.com>
 <20191002234925.9190-5-vishal.l.verma@intel.com> <CAPcyv4hb7vPbWhb3R5fyJH0H5OqRmhtVr=_D0tiYrkc_r8HpaQ@mail.gmail.com>
 <dfd1bdbaa41c3f6e97834d592b32bb10ba562c6a.camel@intel.com>
In-Reply-To: <dfd1bdbaa41c3f6e97834d592b32bb10ba562c6a.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 Oct 2019 13:40:48 -0700
Message-ID: <CAPcyv4hf8rW7D3o6ZaVKcgvG1iQ+H0pZyaz5wjrfzPSyA2Th2g@mail.gmail.com>
Subject: Re: [ndctl PATCH 04/10] libdaxctl: add an API to determine if memory
 is movable
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Message-ID-Hash: 2SSAMQ3ZBHIR6FSKQCX3EMNFLLXQTV4O
X-Message-ID-Hash: 2SSAMQ3ZBHIR6FSKQCX3EMNFLLXQTV4O
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Olson, Ben" <ben.olson@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Biesek, Michal" <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2SSAMQ3ZBHIR6FSKQCX3EMNFLLXQTV4O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 18, 2019 at 12:57 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
>
> On Fri, 2019-10-18 at 11:54 -0700, Dan Williams wrote:
> > On Wed, Oct 2, 2019 at 4:49 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
> > > By default, daxctl always attempts to online new memory sections as
> > > 'movable' so that routine kernel allocations aren't serviced from this
> > > memory, and the memory is later removable via hot-unplug.
> > >
> > > System configuration, or other agents (such as udev rules) may race
> > > 'daxctl' to online memory, and this may result in the memory not being
> > > 'movable'. Add an interface to query the movability of a memory object
> > > associated with a dax device.
> > >
> > > This is in preparation to both display a 'movable' attribute in device
> > > listings, as well as optionally allowing memory to be onlined as
> > > non-movable.
> > >
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Reported-by: Ben Olson <ben.olson@intel.com>
> > > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > > ---
> > >  daxctl/lib/libdaxctl-private.h | 20 +++++++++
> > >  daxctl/lib/libdaxctl.c         | 77 ++++++++++++++++++++++++++++++++--
> > >  daxctl/lib/libdaxctl.sym       |  5 +++
> > >  daxctl/libdaxctl.h             |  1 +
> > >  4 files changed, 100 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
> > > index 7ba3c46..82939bb 100644
> > > --- a/daxctl/lib/libdaxctl-private.h
> > > +++ b/daxctl/lib/libdaxctl-private.h
> > > @@ -44,6 +44,25 @@ enum memory_op {
> > >         MEM_SET_ONLINE,
> > >         MEM_IS_ONLINE,
> > >         MEM_COUNT,
> > > +       MEM_FIND_ZONE,
> >
> > This is private so the naming is not too big a concern, but isn't this
> > a MEM_GET_ZONE? A find operation to me is something that can succeed
> > to find nothing, whereas a get operation fail assumes the association
> > can always be retrieved barring exceptional conditions.
>
> Hm, my personal view of find vs. get was that 'get' grabs a reference
> (or similar) to something which we know how to get to (have a pointer
> directly) etc.

Oh, that's get as in get/put. I'm talking about get/set. Where the
zone is a property memblock that can set and retrieved.

> 'Find' is more of a 'go searching for' something - and it
> may involve walking and looping over data structures.
>
> But I'm not too opposed to this, and can change to 'get' if that follows
> convention better.

Like I said it's private, so it's not a big deal (i.e. API users won't
see it), but ndctl does have a few apis that walk and loop over data
structures using a get verb, or the ones that retrieve the dynamic
state of a sysfs attribute.

I will grant you that in hindsight some of the "get_by" apis might
have been better named "find".
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
