Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B2E137841
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 Jan 2020 22:04:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 16C8D10096C93;
	Fri, 10 Jan 2020 13:07:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1196C100978C0
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 13:07:22 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 66so3286470otd.9
        for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 13:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qFUwI/DrN1zedtZ95ThPN81BQpsB+R5Lz+e+jXfGUY=;
        b=1aySWLEe66fE723txMwEk+0z0GR+oAKdfmvWAbDbQ4ewQrAuvOjXKS43U9uNBT4Di2
         2dm2UtxE0Yp44Mj4CZOypPEdVUar+x2v1TJhOQvH9UQL/CbjE2Ijj4IKu8Y/Niw9UeBD
         fx78HOmZaxpFvlp+DMDV92F8aksKKFyDxCma+UjxZNWoxgbqOlW6A2U1wXMamYdvlSVK
         dZ3z0cduXyTJNoB3UA3qQKKAu3ZbbZsb4oAA+gU3bWYDE+ZuvqYbj5xdZsIeMPcEPKlN
         uxopnKXYH+tv+lwZ5Ls4EIP7dFx6PN/QDpBqkhyXIM3k2e6EsSPwdtyIa4aIxPpJTcOV
         1VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qFUwI/DrN1zedtZ95ThPN81BQpsB+R5Lz+e+jXfGUY=;
        b=crBOABNReYHc0KOiN8w8PgxxYT+VkFzJ0dvSO8Rb3pqR0k5uIFW87OaNPceeAodz/j
         PWB2BDEE5GY/e9qf3edizFkBEbMxHoAen2nbNOij244QBpzIDv2ay5zhG3wXKUqCrpKt
         wWpZq3ea0zaoZKzoB4/0z7KYmEtRJrJE6IcR44trHQ/Cb5UUOrc4LuiwuBPd/XIqhSXW
         ZLaHaqrLGRWfUzpXurvBpx+Y1ZqZpFHuRdilRifqouAXnSTXrG1Z7Ha9xm+0RA0z1FnE
         j7OT9rp2alM0832sE9bNEjgVuOuyYMEBuep189wMIYDXmhsaZHHfie8FwWEvGbyNl7JB
         t/1g==
X-Gm-Message-State: APjAAAWRxvvfEsDRSWJKpHrr1Nhr5/xwSK4yr6zRKQoGudrKFSkRTryY
	azUOdwpCGlkKdemlXekPgnvKcd0950Jq/o4bGhctyw==
X-Google-Smtp-Source: APXvYqzPybULAyIAr+4G30kfW+XAzQ0KkOgnCHK57mKSQL/xSCI5GqnsFW9Wty3atuedmkUr0i7K2/GvLxtmUw9y+nk=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr4305344otk.363.1578690242953;
 Fri, 10 Jan 2020 13:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20200108065219.171221-1-aneesh.kumar@linux.ibm.com> <x49muavm4gx.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49muavm4gx.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 10 Jan 2020 13:03:52 -0800
Message-ID: <CAPcyv4inMqu=CbZo9KGFnHEhZowvcvXXWz67-opDjHATTbimJw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] libnvdimm/namespace: Make namespace size
 validation arch dependent
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: RYCMFWHNYUAAVVKX2CJTW6FKQBMXTPPZ
X-Message-ID-Hash: RYCMFWHNYUAAVVKX2CJTW6FKQBMXTPPZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RYCMFWHNYUAAVVKX2CJTW6FKQBMXTPPZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 10, 2020 at 12:39 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Hi, Aneesh,
>
> After applying this patch series, several of my namespaces no longer
> enumerate:
>
> Before:
>
> # ndctl list
> [
>   {
>     "dev":"namespace0.2",
>     "mode":"sector",
>     "size":106541672960,
>     "uuid":"ea1122b2-c219-424c-b09c-38a6e94a1042",
>     "sector_size":512,
>     "blockdev":"pmem0.2s"
>   },
>   {
>     "dev":"namespace0.1",
>     "mode":"fsdax",
>     "map":"dev",
>     "size":10567548928,
>     "uuid":"68b6746f-481a-4ae6-80b5-71d62176606c",
>     "sector_size":512,
>     "align":4096,
>     "blockdev":"pmem0.1"
>   },
>   {
>     "dev":"namespace0.0",
>     "mode":"fsdax",
>     "map":"dev",
>     "size":52850327552,
>     "uuid":"6d3a0199-5d9a-4fed-830d-e25249b70571",
>     "sector_size":512,
>     "align":2097152,
>     "blockdev":"pmem0"
>   }
> ]
>
> After:
>
> # ndctl list
> [
>   {
>     "dev":"namespace0.0",
>     "mode":"fsdax",
>     "map":"dev",
>     "size":52850327552,
>     "uuid":"6d3a0199-5d9a-4fed-830d-e25249b70571",
>     "sector_size":512,
>     "align":2097152,
>     "blockdev":"pmem0"
>   }
> ]
>
> I won't have time to dig into it this week, but I wanted to mention it
> before Dan merged these patches.
>
> I'll follow up next week with more information.

Thanks Jeff, I hadn't had a chance to dig in on these yet.

Aneesh are you able to run the ndctl unit tests? Even if they don't
run on powerpc you should be able to get them to run on x86 qemu just
to catch the basics.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
