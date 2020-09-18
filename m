Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C1F26EBAE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Sep 2020 04:07:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9CC9B148ED508;
	Thu, 17 Sep 2020 19:07:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0F889148ED506
	for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 19:07:36 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id u21so5996755eja.2
        for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 19:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkI+4n21QSuH4jdlm+1B34+c7MwH6dP62784HBy8ImA=;
        b=f5uT25oZTAiMx8KYkUKgxT6GMBVIz7+wg8g1te6F34gaKViVHpDH3/L8ECgg3Gq/JV
         8qdADzTXlD0jTrgTCyNAMiKd7xDlGy26+e5bwn89Xxocqw9lNqlcbZckRxsdc6DpKphB
         aTas7RYImw40IUsFuC1e2W3UadTq5RvJsCHctAuswp+o0yHP044uXUf42thLOf+bt03R
         6wcYg3iLiBjE2h9pAiVqln2gAE9jTCYCo4HOXva1WTPzb34IhTtEpH/LGL2oHLh1AkrV
         XGokLrCZg5MOZiQcRMZGnxoPqtN30AlMIUqK771gDPf5yFvwdd5eDMCj5fRlbvpm/so/
         4ZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkI+4n21QSuH4jdlm+1B34+c7MwH6dP62784HBy8ImA=;
        b=JUm/SLGKZ8lPeWxPgaH379Nf6cnpbxs7hBZ7p5+ujshQbFk8ZsQlRwDzYuNCzgUWUt
         4Pgy20P7442GG8I0quha9htsCRo+L+xnOEla68+C+mki3UJe8g+czEZgW+9wnEzLG0cU
         8Q4ii9UxJlnU8ZCxSgHMEv3+r82HBOBFs/0hnWBAO3cWBl6s/7rl4gQHzsWhtE6YUHuy
         e4JUKEBh5XMmKEBzqo2oTHcgOcx101qoqJN+nUvbxCi8O3WvBrTP3wZj3Ujithbmbjzr
         zcbWufczpHiYNJi8ndG+CoAQkdTsT7WKwdaXshdO2vx3kPBdjLcz235iKgcb51zoX5G6
         rhKQ==
X-Gm-Message-State: AOAM532g8n1dwibe10KDKEAZ5OnSnsRomyzwfQuvUR4esugVEWFGhbUk
	3PfBF1RfgeWikrzYqTSU9Oh3+LACqQj53fNsKRutXQ==
X-Google-Smtp-Source: ABdhPJztXFD6LqazwudP0FaXKnjG1nNgx+CSOgZ/Fz4EtXih9XripYjVhouODEQROxQuKyDbBQHfDTBpc+Vmsbla/iA=
X-Received: by 2002:a17:907:4035:: with SMTP id nk5mr32973096ejb.418.1600394854609;
 Thu, 17 Sep 2020 19:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200917111549.6367-1-adrianhuang0701@gmail.com>
In-Reply-To: <20200917111549.6367-1-adrianhuang0701@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 17 Sep 2020 19:07:23 -0700
Message-ID: <CAPcyv4hZuhDU--fKjexV-7+=pQk0vwigxO-pzirCjLziski8Fw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] dax: Fix stack overflow when mounting fsdax pmem device
To: Adrian Huang <adrianhuang0701@gmail.com>
Message-ID-Hash: 3C2YLBJAMYS5GHLEUURS2HWTC7XLM2SV
X-Message-ID-Hash: 3C2YLBJAMYS5GHLEUURS2HWTC7XLM2SV
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Yi Zhang <yi.zhang@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, Jan Kara <jack@suse.cz>, Adrian Huang <ahuang12@lenovo.com>, Coly Li <colyli@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3C2YLBJAMYS5GHLEUURS2HWTC7XLM2SV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Sep 17, 2020 at 4:18 AM Adrian Huang <adrianhuang0701@gmail.com> wrote:
>
> From: Adrian Huang <ahuang12@lenovo.com>
>
> When mounting fsdax pmem device, commit 6180bb446ab6 ("dax: fix
> detection of dax support for non-persistent memory block devices")
> introduces the stack overflow [1][2]. Here is the call path for
> mounting ext4 file system:
>   ext4_fill_super
>     bdev_dax_supported
>       __bdev_dax_supported
>         dax_supported
>           generic_fsdax_supported
>             __generic_fsdax_supported
>               bdev_dax_supported
>
> The call path leads to the infinite calling loop, so we cannot
> call bdev_dax_supported() in __generic_fsdax_supported(). The sanity
> checking of the variable 'dax_dev' is moved prior to the two
> bdev_dax_pgoff() checks [3][4].
>
> [1] https://lore.kernel.org/linux-nvdimm/1420999447.1004543.1600055488770.JavaMail.zimbra@redhat.com/
> [2] https://lore.kernel.org/linux-nvdimm/alpine.LRH.2.02.2009141131220.30651@file01.intranet.prod.int.rdu2.redhat.com/
> [3] https://lore.kernel.org/linux-nvdimm/CA+RJvhxBHriCuJhm-D8NvJRe3h2MLM+ZMFgjeJjrRPerMRLvdg@mail.gmail.com/
> [4] https://lore.kernel.org/linux-nvdimm/20200903160608.GU878166@iweiny-DESK2.sc.intel.com/

Thanks for these fixups.

Applied.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
