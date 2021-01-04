Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C328D2EA009
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 Jan 2021 23:32:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 37152100EC1D6;
	Mon,  4 Jan 2021 14:32:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 13319100ED4A3
	for <linux-nvdimm@lists.01.org>; Mon,  4 Jan 2021 14:32:13 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u19so29065672edx.2
        for <linux-nvdimm@lists.01.org>; Mon, 04 Jan 2021 14:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CNKkbP5bNVHuAgZIGpFYMwGvU0izgwTQTTlBMKx9YQ8=;
        b=xE5fzuN0XsaFbOJHmt/INcUo8UZ4uibvDxD6hBEF0gALFoeYE67lhIrGYYt9aXKsfQ
         hlnBcYw/45fROz8pwWHK3XVhbPQTW9Tk1rWQUxnfwCtwZ6Z7dazEDPUfSoofnqpBCKB0
         Suw0WblGHKAkXp/VvQh4z3SnsN/cNSsuOF/5qp55VQLu+LC8zNdUhTT94oaaoAjOcBCR
         siVTvQ4RNkqZ7LYzpsKGT4VBg3jYk67NXHlgJ4YIW6sa3oixm3ysWQPDPrPjAwhXLr28
         ba4loBaaboTVG7ClBEmvpcp7oEvhWja8YVJO4Z3sF3PbP0EhAsKtyFcW9HqgQ3zN4aJX
         2gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNKkbP5bNVHuAgZIGpFYMwGvU0izgwTQTTlBMKx9YQ8=;
        b=YIvFwXQz3mcdjdqD0ZpELf13NhXHRgEdT5k+UUEhRawztVLat1/Cv3u17CP3pfVgzl
         ZY0i40+KVE85VTbhR5jaRJ5po4JVZqPgpUkWUSI8Aq38WXILzJajfmzEWp2hCEFrIw/s
         abM3fsqxkP29y8MaGVd75IhDsROmmWYwSgX4AmsGhsduxkEBCH5sIv+b7IC0lmpEG5GN
         eqLBlFuf8NpMxsmc/Zi55g1pxZjWQBN3Hm3UkHJ5RB482ApAuiClozEL1ZxpPpQRPCej
         JdZPiQivQirPPnDcVd7+L4AuvoPumBBWQArfvohUNp0Y7pHIieAigJdWh9cjB7pq7Lys
         SZYg==
X-Gm-Message-State: AOAM532ZtkdfXVgZc7gcGF+udhycu8RQ+X4qoEy4SWGCofp54aNsBBBn
	oc/HOzCVr2Ga7HvSId+BC3hm76K92fiuAJ/elQSMdw==
X-Google-Smtp-Source: ABdhPJwgQlScu4fnIlw1NCDJTiXhvWQCP91OJ/cNxbzsk7B17ZvvBSc5ynQ42G+5cuhb+Is64/5OCxjJl4QZOqj2C5Y=
X-Received: by 2002:aa7:df0f:: with SMTP id c15mr74055712edy.354.1609799532211;
 Mon, 04 Jan 2021 14:32:12 -0800 (PST)
MIME-Version: 1.0
References: <20201225013546.300116-1-jianpeng.ma@intel.com>
 <20201228171758.GO1563847@iweiny-DESK2.sc.intel.com> <CAPcyv4gm-CnOAYqNYL29TUCQF04f9uCQOgF1ndRpu=_7e6T_kQ@mail.gmail.com>
 <20210104221858.GJ3097896@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20210104221858.GJ3097896@iweiny-DESK2.sc.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 4 Jan 2021 14:32:06 -0800
Message-ID: <CAPcyv4gb3ONLZRtgwrf1toT0o3=_Ke2agdSGjJW3b5mEECf4kA@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/pmem: remove unused header.
To: Ira Weiny <ira.weiny@intel.com>
Message-ID-Hash: QA4YOFIALMJBLHG2R7BZGEXRPC2IKHTM
X-Message-ID-Hash: QA4YOFIALMJBLHG2R7BZGEXRPC2IKHTM
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jianpeng Ma <jianpeng.ma@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QA4YOFIALMJBLHG2R7BZGEXRPC2IKHTM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 4, 2021 at 2:19 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Mon, Jan 04, 2021 at 01:16:32PM -0800, Dan Williams wrote:
> > On Mon, Dec 28, 2020 at 9:18 AM Ira Weiny <ira.weiny@intel.com> wrote:
> > >
> > > On Fri, Dec 25, 2020 at 09:35:46AM +0800, Jianpeng Ma wrote:
> > > > 'commit a8b456d01cd6 ("bdi: remove BDI_CAP_SYNCHRONOUS_IO")' forgot
> > >
> > > This information should be part of a fixes tag.
> >
> > Oh, I was just about to comment "don't provide a Fixes tag for pure
> > cleanups". Fixes is for functional issues that a backporter should
> > consider.
>
> I thought this was discussed recently and it was concluded that 'fixes' does
> not indicate something should be backported?
>
> ...
>
> https://lore.kernel.org/lkml/X8flmVAwl0158872@kroah.com/
>
> At least that is what Greg KH said.  But Dave C. was not happy with this...

I was thinking of it more from the distro automation tooling that I
know fires up it sees a "Fixes" tag. At a minimum this would make
those systems / humans fire up just to notice, "oh, just a plain
cleanup with no logical side-effects".
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
