Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7A8B2620
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Sep 2019 21:33:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 59213202EA40E;
	Fri, 13 Sep 2019 12:33:00 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c43; helo=mail-yw1-xc43.google.com;
 envelope-from=robherring2@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-yw1-xc43.google.com (mail-yw1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8C0C0202EA40A
 for <linux-nvdimm@lists.01.org>; Fri, 13 Sep 2019 12:32:58 -0700 (PDT)
Received: by mail-yw1-xc43.google.com with SMTP id u187so10801304ywa.11
 for <linux-nvdimm@lists.01.org>; Fri, 13 Sep 2019 12:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u15qLOoIkxp7cEiegHHFsMr736/3RxJj/WpvpjNuB/w=;
 b=q4dk0LhsoDsIEBV4EyhB9244sene9/mxhEF+KQV4YKoKPHE7SK7jkZFRbWgUQxR1fB
 yOE/YcUNteeeI3lU1PU9VBugQ+9OUWfGYuD++yg30ZEG4nGnzy5YgkSDAuryxrvfGslY
 m/m4CPUYI/Z5PdoIMxNaDoNyKIEX2zHa7aIf4Yrl7kJGDVDRHoGkujUbm4Q9yjFfh4RG
 FTsL8M2++sRCEMxWENJkGzYqQZywmdwLrDmLkkQZxRgyhGoBw7L6gjDcqrnPTHGdeJJL
 Lc6uQCZg8/11s0MbsSl1Kry0emON3LcNoRIzhfrf2BX0LNuU5YWF7MvHjZoU63S0X9jD
 xdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u15qLOoIkxp7cEiegHHFsMr736/3RxJj/WpvpjNuB/w=;
 b=S0P10duy9QmQ+umPqB7oq5gTAa/xrGWmuWR2IBWctLZmn0yaRQWYXAupvl7chTeINk
 SuQCxWaznib9qYc1URAGfFK2XL6RbDxQj5+bFfe9dMCn5PF5usAvNX/DtqQAB0b54o2Y
 am8sxJUrXOFSRH9lCbgMvAfFaFPNGFJu/BmBaFNe4rfyVmLBlcLL+0no2WynvvOlRhsF
 1ARRR55jEdUF1wHeiYzEu4+Rp+VT9HLwE5n0LRglw6rkRCwEHMqogmBxXylAbaS7g/h2
 JI9cc/xgIX+nbSv5Im9vQ/9uTPw957paIKwaUT4y6DmEMZH2SILnktPCa03GnSnP1L38
 RKQw==
X-Gm-Message-State: APjAAAU4rM1DB8Po+MfXKTTGKEEpeozke70IvJXJHWSEXVSKaW+5yVSu
 eHoT7O+Y3gdpxM5gGJVJzcC6hFXvL8dy51tA4A==
X-Google-Smtp-Source: APXvYqzl9Gmz00Dm5vFdc8rEO+frJ4ZNkwLJ1YEPQUO83/7IjTjFzgLFJ+QiOPrUAgRD1X21OU3A4ibVOH9g531GgIE=
X-Received: by 2002:a81:9182:: with SMTP id
 i124mr31070145ywg.279.1568403185288; 
 Fri, 13 Sep 2019 12:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <20190913010937.7fc20d93@lwn.net> <20190913114849.GP20699@kadam>
 <b579153b-3f6d-722c-aea8-abc0d026fa0d@infradead.org>
 <CAL_JsqLo9-zQYGj2vaEWppbioO0rXu-QNbHhydYdMgrZo0_ESg@mail.gmail.com>
 <f0ad46a34078a2c1eaa013f9b1a5a52becbcd1c5.camel@perches.com>
In-Reply-To: <f0ad46a34078a2c1eaa013f9b1a5a52becbcd1c5.camel@perches.com>
From: Rob Herring <robherring2@gmail.com>
Date: Fri, 13 Sep 2019 14:32:53 -0500
Message-ID: <CAL_JsqKOyLefjdW3a7m8fmqSGXAo4CCx2mZzi-JPf5qKD1NWxA@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To: Joe Perches <joe@perches.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: ksummit <ksummit-discuss@lists.linuxfoundation.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Randy Dunlap <rdunlap@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 bpf@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Sep 13, 2019 at 11:42 AM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-09-13 at 16:46 +0100, Rob Herring wrote:
> > On Fri, Sep 13, 2019 at 4:00 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > On 9/13/19 4:48 AM, Dan Carpenter wrote:
> > >
> > > > > So I'm expecting to take this kind of stuff into Documentation/.  My own
> > > > > personal hope is that it can maybe serve to shame some of these "local
> > > > > quirks" out of existence.  The evidence from this brief discussion suggests
> > > > > that this might indeed happen.
> > > >
> > > > I don't think it's shaming, I think it's validating.  Everyone just
> > > > insists that since it's written in the Book of Rules then it's our fault
> > > > for not reading it.  It's like those EULA things where there is more
> > > > text than anyone can physically read in a life time.
> > >
> > > Yes, agreed.
> > >
> > > > And the documentation doesn't help.  For example, I knew people's rules
> > > > about capitalizing the subject but I'd just forget.  I say that if you
> > > > can't be bothered to add it to checkpatch then it means you don't really
> > > > care that strongly.
> > >
> > > If a subsystem requires a certain spelling/capitalization in patch email
> > > subjects, it should be added to MAINTAINERS IMO.  E.g.,
> > > E:      NuBus
> >
> > +1
> >
> > Better make this a regex to deal with (net|net-next).
> >
> > We could probably script populating MAINTAINERS with this using how it
> > is done manually: git log --oneline <dir>
>
> I made a similar proposal nearly a decade ago to add a grammar
> to MAINTAINERS sections for patch subject prefixes.
>
> https://lore.kernel.org/lkml/1289919077.28741.50.camel@Joe-Laptop/

Perhaps there's more support for it now. I didn't get through all the
thread, but the positions seemed to range from "who cares, subjects
are easy to edit" to "seems like a good idea and doesn't hurt". I
probably would have implemented something, but perl (tacking on to
checkpatch and having you tell me everything wrong is about all I can
do :)).

Rob
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
