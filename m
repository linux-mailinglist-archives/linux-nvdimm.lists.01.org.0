Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC4D12FC2E
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Jan 2020 19:18:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1EE1610097F36;
	Fri,  3 Jan 2020 10:21:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6C6411011366C
	for <linux-nvdimm@lists.01.org>; Fri,  3 Jan 2020 10:21:53 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id a67so14755508oib.6
        for <linux-nvdimm@lists.01.org>; Fri, 03 Jan 2020 10:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8jfW1W8ZPOpcKWgvKCt6rdwp9cvHKeFm7M8ZtVMfoqE=;
        b=uUTSYWl8nz82vjdvvs/xw9mCFGyNA1/jWIoEbWuoMKlH3HcUmcrmAqAMT/hIMBHdeM
         Fuby+QAs66gLq4zerv1qQgWzxoVD8/r0SSdFiVPRB1KIlrgk+Ia/w09w2yIVb5UjPUKe
         aPbAUa8sDKqS+Z4oOye+qJxT2xWQdMreVtrK0E0UvXvfqOeelWZW8PJqgrqw9dRkK6uk
         n02sLzh2qbjLYtP6eE1hXlSk3R0Qtd222mErsWQ1QRt3DyYfq3l8wWs0f8OFXi4RxUqR
         Miqm3MNSWzoZ2hZI/iAGOnFy0qTR/HSd977eHvvgAqYPyJXhnZLiJOZszpwfj8/ebisx
         Q1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jfW1W8ZPOpcKWgvKCt6rdwp9cvHKeFm7M8ZtVMfoqE=;
        b=bjqX+G9rSAQVFXIrIYjhdUVC2go6RTFWJMCfTEqT6P/sHBrQZcUJqN0JB4XYBNevfS
         ZeKaXhclKulQ3nuNnWErwAPu5dqlpwtUyHEnZ2IQ0RRp1cRzZogLguW+9Q0QzusCuE9n
         oM4zjSj3AxDC5Bak6UWPAznmtsbYIE40m6ilMR0llj1xItGvtIg0bBkMK9GhPwUDwhfV
         qS7ot/qlFJzyiPcldFkKs8z+YxiZoomal3nPt+aEPOS8N1i/6abdXrKp/A/PAC+6gaj5
         UZpJR9v5hztrLHUfCCqqgB8NwW+ls1rJaIi0SRk0XusIc0CUFiHrb/6aWzdIOjo2jQAc
         BSAQ==
X-Gm-Message-State: APjAAAXTYM2pjvWqjDriZgis2e5Syt5/Wn3qMid2Bj0C7F0UPwpjWhBJ
	P43xiNrOomucP53jjW0YcIDyhcCe+qNZfyFlQnE7Fg==
X-Google-Smtp-Source: APXvYqy2IVKMiHQ+wQTZ+ASoUXECP3V0RjbOEIgTCxr3TvAGQIi/fJSFNpOGIKISyhHaPla/bwRt9Ai9ZKS192hUFSE=
X-Received: by 2002:a05:6808:b37:: with SMTP id t23mr4590187oij.149.1578075513071;
 Fri, 03 Jan 2020 10:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20190821175720.25901-1-vgoyal@redhat.com> <20190821175720.25901-3-vgoyal@redhat.com>
 <20190826115316.GB21051@infradead.org> <20190826203326.GB13860@redhat.com>
 <20190826205829.GC13860@redhat.com> <20200103141235.GA13350@redhat.com> <CAPcyv4hr-KXUAT_tVy-GuTOq1GvVGHKsHwAPih60wcW3DGmqRg@mail.gmail.com>
In-Reply-To: <CAPcyv4hr-KXUAT_tVy-GuTOq1GvVGHKsHwAPih60wcW3DGmqRg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 3 Jan 2020 10:18:22 -0800
Message-ID: <CAPcyv4jM8s8T5ifv0c2eyqaBu3f2bd_j+fQHmJttZAajZ-we=g@mail.gmail.com>
Subject: Re: [PATCH 02/19] dax: Pass dax_dev to dax_writeback_mapping_range()
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: 2CME5XO7GWA3KMJ7JW6IG2QOJ62YGBXE
X-Message-ID-Hash: 2CME5XO7GWA3KMJ7JW6IG2QOJ62YGBXE
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com, Miklos Szeredi <miklos@szeredi.hu>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christoph Hellwig <hch@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2CME5XO7GWA3KMJ7JW6IG2QOJ62YGBXE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 3, 2020 at 10:12 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jan 3, 2020 at 6:12 AM Vivek Goyal <vgoyal@redhat.com> wrote:
[..]
> > Hi Dan,
> >
> > Ping for this patch. I see christoph and Jan acked it. Can we take it. Not
> > sure how to get ack from ext4 developers.
>
> Jan counts for ext4, I just missed this. Now merged.

Oh, this now collides with:

   30fa529e3b2e xfs: add a xfs_inode_buftarg helper

Care to rebase? I'll also circle back to your question about
partitions on patch1.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
