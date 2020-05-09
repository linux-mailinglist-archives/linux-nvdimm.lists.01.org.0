Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A2C1CC250
	for <lists+linux-nvdimm@lfdr.de>; Sat,  9 May 2020 17:07:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 19EE911820224;
	Sat,  9 May 2020 08:05:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D50BA11820221
	for <linux-nvdimm@lists.01.org>; Sat,  9 May 2020 08:05:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id yc10so1994338ejb.12
        for <linux-nvdimm@lists.01.org>; Sat, 09 May 2020 08:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLn1AXHn00bZ+po9Vb7k6qNSHYdWGkkZ6wxI2pwtGRE=;
        b=bCOSwnBBjfPXdvYGJ+yVECFvPTePDH1ANyISrMhvJ1qWqJvVThnHr98KsSwJqA14nC
         yCPOxIRhJYUKs+I0Z7zlDnbc2VJgVwWpDdEA4tIPWEVVkzgs6TyhzHr/LnVPIJc5YbZe
         /Ga31Bb5nRqdr5sF01D+4kD7nuppvALvlvKumT0LdbEKLra5xfeiNf57Wv0ExKnHb7Rg
         DbJPWuDEL/VR1p8vve4AZ1c4iNgOcgeDoJddMOToTohvJc+NMCp5pllqs5xHvWVFoT1b
         hZ2eMoVCvm/W3nphozJEpzuE720t10XyAVjkj8Y23QAnpJ3YgiSQvtyoRGLEW8+4DwBB
         HlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLn1AXHn00bZ+po9Vb7k6qNSHYdWGkkZ6wxI2pwtGRE=;
        b=aJL3FIv9e3OccpyHDBohHEYKua05c3HycOakbJXlyRCmqABUAmfT3IoZ13/bamIcbD
         LJKf5qJ9SEBw1cjNsKFBKUFk16umFhmwQesQED872xHvJmkqtQNT3kseykBVu86sYCFg
         cxDYcvkaFjKXiWm4y1XzPrw6NSMGpAheOLf0ftXVyLRCBCrqKYWTOpZC8G6n7EZNMlFq
         YHkXWgGGQ1aX1Hq5VaQBYsWlgj4Fti82AD6pvvnO9V4+qAIu8zA5z/JH3BUIfNKKC2mg
         VmAtW8/9u/qH14Ray7uwZzfp+MgUtOfrLBBdKGYamW2AJXDjcZxe5yPLmz2g4O5Y4hLa
         zOtg==
X-Gm-Message-State: AGi0Pua5q3Y+O4dC3h7xeTK7v2JauTKog7NCv8KIZI+LgbWLXIgJE6Gx
	8xuG47+tSXnUbJ8cKw73O5PZDh5E9nnfWoJhvHKBxg==
X-Google-Smtp-Source: APiQypKilW3QgeYL9j+z8BH4y4sSKlWKWi60GEoJhZT78wFbACZI36hD4PovUMVH8UfEyvLbc+3je7NxPGD32jSs39Q=
X-Received: by 2002:a17:906:855a:: with SMTP id h26mr6685025ejy.56.1589036845508;
 Sat, 09 May 2020 08:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200508161517.252308-1-hch@lst.de> <CAPcyv4j3gVqrZWCCc2Q-6JizGAQXW0b+R1BcvWCZOvzaukGLQg@mail.gmail.com>
 <20200509082352.GB21834@lst.de>
In-Reply-To: <20200509082352.GB21834@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 9 May 2020 08:07:14 -0700
Message-ID: <CAPcyv4ggb7_rwzGbhHNXSHd+jjSpZC=+DMEztY6Cu8Bc=ZNzag@mail.gmail.com>
Subject: Re: remove a few uses of ->queuedata
To: Christoph Hellwig <hch@lst.de>
Message-ID-Hash: FYPOGMFN4XZOFMMYI5Z4ZTZHC6CHOITT
X-Message-ID-Hash: FYPOGMFN4XZOFMMYI5Z4ZTZHC6CHOITT
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jens Axboe <axboe@kernel.dk>, Jim Paris <jim@jtan.com>, Geoff Levand <geoff@infradead.org>, Joshua Morris <josh.h.morris@us.ibm.com>, Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-m68k@lists.linux-m68k.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-bcache@vger.kernel.org, linux-raid <linux-raid@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FYPOGMFN4XZOFMMYI5Z4ZTZHC6CHOITT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, May 9, 2020 at 1:24 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, May 08, 2020 at 11:04:45AM -0700, Dan Williams wrote:
> > On Fri, May 8, 2020 at 9:16 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Hi all,
> > >
> > > various bio based drivers use queue->queuedata despite already having
> > > set up disk->private_data, which can be used just as easily.  This
> > > series cleans them up to only use a single private data pointer.
> >
> > ...but isn't the queue pretty much guaranteed to be cache hot and the
> > gendisk cache cold? I'm not immediately seeing what else needs the
> > gendisk in the I/O path. Is there another motivation I'm missing?
>
> ->private_data is right next to the ->queue pointer, pat0 and part_tbl
> which are all used in the I/O submission path (generic_make_request /
> generic_make_request_checks).  This is mostly a prep cleanup patch to
> also remove the pointless queue argument from ->make_request - then
> ->queue is an extra dereference and extra churn.

Ah ok. If the changelogs had been filled in with something like "In
preparation for removing @q from make_request_fn, stop using
->queuedata", I probably wouldn't have looked twice.

For the nvdimm/ driver updates you can add:

    Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...or just let me know if you want me to pick those up through the nvdimm tree.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
