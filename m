Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5864F1D2205
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 May 2020 00:27:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 63F5711AD4961;
	Wed, 13 May 2020 15:24:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 08FE611A31CDC
	for <linux-nvdimm@lists.01.org>; Wed, 13 May 2020 15:24:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id s9so1018132eju.1
        for <linux-nvdimm@lists.01.org>; Wed, 13 May 2020 15:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gtvWq/MeF/6oEmnw1qXQmZlv3KNk4h6BjoEUKhO/AI=;
        b=qnuaqcZyt8F/fu6JacXR348SsoSa3Tm7AzZNuvdyRoTov1keyBvQu8pXUwf75HxiOf
         Kp75KOKoGDVG9AVOlHoBHnEOZ+aGnlYmnNxamZckzNM5gr/kauOLnvq8RbJVSj57g1cw
         9NN4htlh7EN6fcqVbepwUivXJDqDlyuHYUdtHPY21wxmzjXy/ZgI5w7jQM2uM22NfFtA
         q8lS8JkKuJziplyt33amkKJeLTRetS+ezNJTjHtj9SEkChz+0OHqn2TMVceqrJ2eD/4/
         0tsEvnEt2hykkPAkDhJ48WHxBHzBhAZBdTwTt86tywE0BQeuxSyyhNQdkXE9MGPz7xQ5
         Snkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gtvWq/MeF/6oEmnw1qXQmZlv3KNk4h6BjoEUKhO/AI=;
        b=scyM2v6F96hfXHQifOQB/G8bi2cB/AtvhlDK3pjxjZwzH7l+s6eccNf3DRaY7aLqQW
         vqwFRfPhMiPGu4znxctRkU/7wFwwkk2L/KgomTdkXLwvnApXlt0GvU4XD1DO8q3waEjL
         8B19eV/+27AILTn5TBreWP6v3buVnPX+LBSoJDvsNax+8ubviaaTy+ygQvNK5SrgF7Ln
         BVQIZ5xQV8ID9k2IgmxH/wHwZu6wAjevXoe5fv4ChV7qbjKrouklWW5twg/2hsISjiyp
         zl02NgSECKDFkqcJJsb32f3aqbZSpv2NnPK7NIBnCfRiU6EHXLtXC1PJQMiOh1v8eXAv
         NAMA==
X-Gm-Message-State: AOAM532JKMOvxHpfppainEm9PqQjrQMrYPe5AfnnO0A3Fb+SRQ/Hp09e
	rWk/pwLNqycrTtYUYnparRNs2tL1sHfDeLwnQ4JJ+w==
X-Google-Smtp-Source: ABdhPJz1YkZyiu1OaSAVXpO2AAQnxlh/qNnka1A5+jaiVwuM2r/ADoB+8k1+qusteX+AGprilg7rK2SWSnm96LhSDK4=
X-Received: by 2002:a17:906:1f8b:: with SMTP id t11mr1180169ejr.201.1589408817417;
 Wed, 13 May 2020 15:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200508161517.252308-1-hch@lst.de> <CAPcyv4j3gVqrZWCCc2Q-6JizGAQXW0b+R1BcvWCZOvzaukGLQg@mail.gmail.com>
 <20200509082352.GB21834@lst.de> <CAPcyv4ggb7_rwzGbhHNXSHd+jjSpZC=+DMEztY6Cu8Bc=ZNzag@mail.gmail.com>
 <20200512080820.GA2336@lst.de>
In-Reply-To: <20200512080820.GA2336@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 13 May 2020 15:26:45 -0700
Message-ID: <CAPcyv4iWB=ZMmpc1aWfpJabSbCdvB28dCeSp_xj7AZMfbF_rjg@mail.gmail.com>
Subject: Re: remove a few uses of ->queuedata
To: Christoph Hellwig <hch@lst.de>
Message-ID-Hash: 3PMR5LBRMNYWAWHLDZOC256NSLBDY7AZ
X-Message-ID-Hash: 3PMR5LBRMNYWAWHLDZOC256NSLBDY7AZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jens Axboe <axboe@kernel.dk>, Jim Paris <jim@jtan.com>, Geoff Levand <geoff@infradead.org>, Joshua Morris <josh.h.morris@us.ibm.com>, Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-m68k@lists.linux-m68k.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-bcache@vger.kernel.org, linux-raid <linux-raid@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3PMR5LBRMNYWAWHLDZOC256NSLBDY7AZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 12, 2020 at 1:08 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sat, May 09, 2020 at 08:07:14AM -0700, Dan Williams wrote:
> > > which are all used in the I/O submission path (generic_make_request /
> > > generic_make_request_checks).  This is mostly a prep cleanup patch to
> > > also remove the pointless queue argument from ->make_request - then
> > > ->queue is an extra dereference and extra churn.
> >
> > Ah ok. If the changelogs had been filled in with something like "In
> > preparation for removing @q from make_request_fn, stop using
> > ->queuedata", I probably wouldn't have looked twice.
> >
> > For the nvdimm/ driver updates you can add:
> >
> >     Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> >
> > ...or just let me know if you want me to pick those up through the nvdimm tree.
>
> I'd love you to pick them up through the nvdimm tree.  Do you want
> to fix up the commit message yourself?

Will do, thanks.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
