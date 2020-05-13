Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EBB1D1DC7
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 May 2020 20:45:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A923311AB2D1A;
	Wed, 13 May 2020 11:43:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=song@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7255911AB2D18
	for <linux-nvdimm@lists.01.org>; Wed, 13 May 2020 11:43:01 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id D9B20207CD
	for <linux-nvdimm@lists.01.org>; Wed, 13 May 2020 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589395541;
	bh=y3uf4cDEBcGin/ahVjDWwwqBbdeSBPGoaou/iCBc+Ng=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RLQfxHVcrn6lWhWEu0DDrnMIHIoZ+37WfrxEpZxqiKdV1WCyAtQwcUcFu2SvS2080
	 VTE5vGbKGPtkrp13IOlhl2+f6sYzR7NeAlwZhvD/+sHUP7ta5YnAY2Vdmt9jo9N04s
	 CEpGnXvJbsQIZi+fuoRT8dDY4nvc1HnFSDyGGc2w=
Received: by mail-lj1-f182.google.com with SMTP id d21so702702ljg.9
        for <linux-nvdimm@lists.01.org>; Wed, 13 May 2020 11:45:39 -0700 (PDT)
X-Gm-Message-State: AOAM530KPiMX2so8F9XXpvbLPqdziS0vz/tl6TIC9x4C3sIAkk6EfPqS
	2OgzAXGrGON+bHl4Yif3wGgjbxR2uTnI1+sBICY=
X-Google-Smtp-Source: ABdhPJzyHaUiiK2XwtDLa9MHZHs3wyCWyuE6aX0bNKMPXZmRZyv4SYSAs5m7n5jeU7J7JeAy2/ppnnbYCoByE6/YYa8=
X-Received: by 2002:a2e:9258:: with SMTP id v24mr280263ljg.109.1589395538071;
 Wed, 13 May 2020 11:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200508161517.252308-1-hch@lst.de> <20200508161517.252308-13-hch@lst.de>
 <CAPhsuW6_Y53_XLFeVxhTDpTi_PKNLqqnrXLn+M2fJW268eE6_w@mail.gmail.com> <20200513183304.GA29895@lst.de>
In-Reply-To: <20200513183304.GA29895@lst.de>
From: Song Liu <song@kernel.org>
Date: Wed, 13 May 2020 11:45:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6pG+-EAa-FW96r+LEP=j1nWEK0Zqk_fJeaAu2Hn9AqeA@mail.gmail.com>
Message-ID: <CAPhsuW6pG+-EAa-FW96r+LEP=j1nWEK0Zqk_fJeaAu2Hn9AqeA@mail.gmail.com>
Subject: Re: [PATCH 12/15] md: stop using ->queuedata
To: Christoph Hellwig <hch@lst.de>
Message-ID-Hash: N325BU5QKIR5AS7ZIXXEEW22ZGCT3RGO
X-Message-ID-Hash: N325BU5QKIR5AS7ZIXXEEW22ZGCT3RGO
X-MailFrom: song@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jens Axboe <axboe@kernel.dk>, Jim Paris <jim@jtan.com>, Geoff Levand <geoff@infradead.org>, Joshua Morris <josh.h.morris@us.ibm.com>, Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-m68k@lists.linux-m68k.org, open list <linux-kernel@vger.kernel.org>, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid <linux-raid@vger.kernel.org>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/N325BU5QKIR5AS7ZIXXEEW22ZGCT3RGO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 13, 2020 at 11:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, May 13, 2020 at 11:29:17AM -0700, Song Liu wrote:
> > On Fri, May 8, 2020 at 9:17 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Thanks for the cleanup. IIUC, you want this go through md tree?
>
> Yes, please pick it up though the md tree.

Thanks for the clarification. Applied to md-next.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
