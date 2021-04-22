Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D4B368479
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Apr 2021 18:12:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 93DB5100EAB77;
	Thu, 22 Apr 2021 09:12:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=djwong@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5184D100EAB71
	for <linux-nvdimm@lists.01.org>; Thu, 22 Apr 2021 09:12:43 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFE77613FA;
	Thu, 22 Apr 2021 16:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1619107961;
	bh=StivcVD9xXu0rWnliGlK3Di9LBDcwLdEvblI2w8R7OM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LqZlGEbuM6/TYtsddHzWNpv36nTueJY4ONSELqRugx9Rgkmb62aoGknxJuFj1K81o
	 L2MjJKkoNaS83JMzkN4kfTtjWgdmcac2ZINLJazYAr9eWwRC43Rp8jWq8Jx2ZV9B0C
	 VMsMugEgCvT+Wp5Qg1HuNYg6I4iUJ3p1MRsPk6ITCK+CBvJZ+9fpGqieNNMzhQ0SBg
	 MgJWx8hRiuym2vygfMs/yTnUsL/AWKWjLFm+bq7/cCRLjt+DuIJzC3ZRTaGzeZ7Lc8
	 sgZ+C+SsId/LlpV9Ih32OYwQBxRxM/T/yGA/fueHe3P2i/0hAeyUFfgMHxNm7XhWX/
	 M9FWcEL1YvG6g==
Date: Thu, 22 Apr 2021 09:12:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [Virtio-fs] [PATCH v3 2/3] dax: Add a wakeup mode parameter to
 put_unlocked_entry()
Message-ID: <20210422161241.GC547183@magnolia>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
 <20210419213636.1514816-3-vgoyal@redhat.com>
 <20210420093420.2eed3939@bahia.lan>
 <20210420140033.GA1529659@redhat.com>
 <CAPcyv4g2raipYhivwbiSvsHmSdgLO8wphh5dhY3hpjwko9G4Hw@mail.gmail.com>
 <20210422062458.GA4176641@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210422062458.GA4176641@infradead.org>
Message-ID-Hash: EOCKXIV23RLALXPOLFG53BLAHPQ3B27U
X-Message-ID-Hash: EOCKXIV23RLALXPOLFG53BLAHPQ3B27U
X-MailFrom: djwong@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Greg Kurz <groug@kaod.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Miklos Szeredi <miklos@szeredi.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtio-fs-list <virtio-fs@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EOCKXIV23RLALXPOLFG53BLAHPQ3B27U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 22, 2021 at 07:24:58AM +0100, Christoph Hellwig wrote:
> On Wed, Apr 21, 2021 at 12:09:54PM -0700, Dan Williams wrote:
> > Can you get in the habit of not replying inline with new patches like
> > this? Collect the review feedback, take a pause, and resend the full
> > series so tooling like b4 and patchwork can track when a new posting
> > supersedes a previous one. As is, this inline style inflicts manual
> > effort on the maintainer.
> 
> Honestly I don't mind it at all.  If you shiny new tooling can't handle
> it maybe you should fix your shiny new tooling instead of changing
> everyones workflow?

Just speaking for XFS here, but I don't like inline resubmissions
because that makes it /really/ hard to find the original patch 6 months
later when everything has paged out of my brain but random enterprise
distro backporters start asking questions ("is this an actively
exploited security fix?" "what were you smoking?" etc).

At least change the subject line to something that screams "new patch!"
so that mutt and lore will make it stand out.

(Granted this isn't XFS, so I am not the enforcer here ;))

--D
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
