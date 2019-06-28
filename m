Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612B15A46B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 20:44:50 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EA242212AB4F7;
	Fri, 28 Jun 2019 11:44:48 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B582821297063
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 11:44:47 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id j19so6999345otq.2
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BNY+UkoJVrKxCjM2c24Xgrzfzfk/Z55i3p1E82IfUT4=;
 b=zI1Rfkj72TaacEJj7GZa9aQH2dQpodMnoVTwnXEaBlMSZNhY5OVVCjVG5znvL8YDvw
 /w4yi2CZ3bmDcg8+jo0W3xW8odrHcZ2aCHGJ87xs+2ltcljxDeJN66gvtxIzrVxNLxkg
 pL7hur4fQE0hdbPpJ33d47KRUWZSM8qnBIPWODQs6LDS5RSktDpzI29k0ILuZRejss34
 xnFlTPIYvocsrjjzZCQI/0Yj+GNH//C0I7LZJ/r3XYMiRT+Tq5iZQhNf2bG7bpRfCfUN
 VI7eLoWpW+vIxkXl125Fq7E2Z95KiI815ewg7Kq0wfihaAtAnAzS1E/XQAxSbE8m8Iyo
 kZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BNY+UkoJVrKxCjM2c24Xgrzfzfk/Z55i3p1E82IfUT4=;
 b=I+jPjMVjzeHH58pqOd5lGYhLQH/NDSJj1J9TXcUpxkpeEQNQaAUMHtFAhRRCHfFu3t
 GFxhTeCC+krxwtmuECDXAJi+smw/7lQECGQJvFG7d/YcHFOTvOUYgPARJuzzqJ2PenwT
 +65aWY29XxUMcMCBFiBYzqD/Z+pKJVCEkKrpS2D8yQk3FRImrmrd7QG+NOLhhfcwvPqM
 1EbT2XFn005AF/JV96qibKZbdG8z9pUv+uDm7n3XNcuZE8Ztw+PwK/lAMnyID5Zmpawt
 Z3xnVuXs38Ihr+5gxvM/A0gLyMTuXreg8ENt5A0LWTEjAR5pXmgfDAkP9mSYd9E7MK9j
 KlvA==
X-Gm-Message-State: APjAAAV070IzLoA9T4MVIYDbM6mQUA2joakYM0PGJYJst3mP1h8oYmfk
 NVkZ5vj2vhITQPo41cSPbmtxKlV2UC5og1X9e4D8DA==
X-Google-Smtp-Source: APXvYqy1WcVZusxQT3gsMqR8FxlPuXMWtxZvhAO+zU3jLT7QJNrvbdWUjpng3sXAK8TgdSWU7HjEXIzdeabvXlDD8go=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr9063478oto.207.1561747486699; 
 Fri, 28 Jun 2019 11:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-17-hch@lst.de>
 <20190628153827.GA5373@mellanox.com>
 <CAPcyv4joSiFMeYq=D08C-QZSkHz0kRpvRfseNQWrN34Rrm+S7g@mail.gmail.com>
 <20190628170219.GA3608@mellanox.com>
 <CAPcyv4ja9DVL2zuxuSup8x3VOT_dKAOS8uBQweE9R81vnYRNWg@mail.gmail.com>
 <CAPcyv4iWTe=vOXUqkr_CguFrFRqgA7hJSt4J0B3RpuP-Okz0Vw@mail.gmail.com>
 <20190628182922.GA15242@mellanox.com>
In-Reply-To: <20190628182922.GA15242@mellanox.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 28 Jun 2019 11:44:35 -0700
Message-ID: <CAPcyv4g+zk9pnLcj6Xvwh-svKM+w4hxfYGikcmuoBAFGCr-HAw@mail.gmail.com>
Subject: Re: [PATCH 16/25] device-dax: use the dev_pagemap internal refcount
To: Jason Gunthorpe <jgg@mellanox.com>
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
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 28, 2019 at 11:29 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Fri, Jun 28, 2019 at 10:10:12AM -0700, Dan Williams wrote:
> > On Fri, Jun 28, 2019 at 10:08 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Fri, Jun 28, 2019 at 10:02 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > > >
> > > > On Fri, Jun 28, 2019 at 09:27:44AM -0700, Dan Williams wrote:
> > > > > On Fri, Jun 28, 2019 at 8:39 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > > > > >
> > > > > > On Wed, Jun 26, 2019 at 02:27:15PM +0200, Christoph Hellwig wrote:
> > > > > > > The functionality is identical to the one currently open coded in
> > > > > > > device-dax.
> > > > > > >
> > > > > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > > > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > > > > >  drivers/dax/dax-private.h |  4 ----
> > > > > > >  drivers/dax/device.c      | 43 ---------------------------------------
> > > > > > >  2 files changed, 47 deletions(-)
> > > > > >
> > > > > > DanW: I think this series has reached enough review, did you want
> > > > > > to ack/test any further?
> > > > > >
> > > > > > This needs to land in hmm.git soon to make the merge window.
> > > > >
> > > > > I was awaiting a decision about resolving the collision with Ira's
> > > > > patch before testing the final result again [1]. You can go ahead and
> > > > > add my reviewed-by for the series, but my tested-by should be on the
> > > > > final state of the series.
> > > >
> > > > The conflict looks OK to me, I think we can let Andrew and Linus
> > > > resolve it.
> > >
> > > Andrew's tree effectively always rebases since it's a quilt series.
> > > I'd recommend pulling Ira's patch out of -mm and applying it with the
> > > rest of hmm reworks. Any other git tree I'd agree with just doing the
> > > late conflict resolution, but I'm not clear on what's the best
> > > practice when conflicting with -mm.
>
> What happens depends on timing as things arrive to Linus. I promised
> to send hmm.git early, so I understand that Andrew will quilt rebase
> his tree to Linus's and fix the conflict in Ira's patch before he
> sends it.
>
> > Regardless the patch is buggy. If you want to do the conflict
> > resolution it should be because the DEVICE_PUBLIC removal effectively
> > does the same fix otherwise we're knowingly leaving a broken point in
> > the history.
>
> I'm not sure I understand your concern, is there something wrong with
> CH's series as it stands? hmm is a non-rebasing git tree, so as long
> as the series is correct *when I apply it* there is no broken history.
>
> I assumed the conflict resolution for Ira's patch was to simply take
> the deletion of the if block from CH's series - right?
>
> If we do need to take Ira's patch into hmm.git it will go after CH's
> series (and Ira will have to rebase/repost it), so I think there is
> nothing to do at this moment - unless you are saying there is a
> problem with the series in CH's git tree?

There is a problem with the series in CH's tree. It removes the
->page_free() callback from the release_pages() path because it goes
too far and removes the put_devmap_managed_page() call.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
