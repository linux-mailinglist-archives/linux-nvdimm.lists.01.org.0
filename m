Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBD43070BD
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 Jan 2021 09:12:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7BF93100F226B;
	Thu, 28 Jan 2021 00:12:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5B8FB100F226A
	for <linux-nvdimm@lists.01.org>; Thu, 28 Jan 2021 00:12:28 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f1so5536678edr.12
        for <linux-nvdimm@lists.01.org>; Thu, 28 Jan 2021 00:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Z97xznp/gZd6cEGbFY9jieqS12AGD/WIHa2j6j3J8c=;
        b=eJ3xM8hRtaerYP+OiPbjifre40bo2eCDwJd0GX6n0g9wrQQeuf8qahWyPsRhj19a2V
         VzQY/rSTKoffLYvbP4ZndZw3PWheE7n2iQzXwzqXaFcinwXWPhU+WqTASiS6HgMJGSfl
         meSKnBCv8wCQawXPoGx9q8yCK9ULi91eigONZ4VyA20DmVKBa/ouhzOqBK6b+w6FIOCI
         btG9MzVjVobaf20LoUD2/0xrnUh/9q++WRwB/ub+T5ygkAqc3mK8k2lZu5xcFo7N4a44
         u4VnNxSbE0iHtiiuLdr9oA8rP1OuAF8rgMLSAzVjSWdvxWpunhzFpITpqjcGTqzwVdip
         3mJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Z97xznp/gZd6cEGbFY9jieqS12AGD/WIHa2j6j3J8c=;
        b=lDTZTCinNbEHL8dtTKj75GYC/iJ0l1yYxfChh07rZO+/qm41hfxhSE7Khrn/2nKrzW
         UKawkibPA3UH1h+as3ZyJiLCCpRObqbrQGGCWdcJy3F7HK6O9C7j791BgYsYx+djwOvz
         riEAbfl5jlA/fQ0T0NkhMB0NXEsidCXOu20WvXYaJ+v/aVah9GMc7pZrgk+PzMpgs+Nr
         MEVwOeCc98BHdVC6W6uv5VV07mEWVZhzDNc69keX8RoO4QhvJYe125FFXv8QVLZvw9C0
         Y879WIyM7JB+wRTm+TApJPQFnM9GxDR8Tek4zyHt4vZwuxlh28mMD8GhZF9Fn3KtPpCG
         qjEw==
X-Gm-Message-State: AOAM533Hofv4gJL29bWHt+bQAX3Fv3jBf3pvoox8uXc5i+dnQ+ok3D4F
	BpvIeLhh8TumyOn9jWcLOhMfSCGcQSomkeMCDzdyJw==
X-Google-Smtp-Source: ABdhPJwYR292Ll2cYAONjRwJI0aX7E3GwpIWbleEL5WsEzc3wGRNAH3eSGzfDSc1zm67wayGG1IKVZYyi7Gpe/+YhWs=
X-Received: by 2002:aa7:d610:: with SMTP id c16mr13120127edr.354.1611821545835;
 Thu, 28 Jan 2021 00:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20201214103859.2409175-1-santosh@fossix.org>
In-Reply-To: <20201214103859.2409175-1-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 28 Jan 2021 00:12:23 -0800
Message-ID: <CAPcyv4i2n-B873sz0TY--diutJ5pycNHASpnrs=u-8c8hjPBsQ@mail.gmail.com>
Subject: Re: [RFC v5 0/7] PMEM device emulation without nfit depenency
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: 4PAKOJ4IVRFJI22EUPFMNZRRD6XG6JBG
X-Message-ID-Hash: 4PAKOJ4IVRFJI22EUPFMNZRRD6XG6JBG
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4PAKOJ4IVRFJI22EUPFMNZRRD6XG6JBG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Dec 14, 2020 at 2:39 AM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> The current test module cannot be used for testing platforms (make check)
> that do not have support for NFIT. In order to get the ndctl tests working,
> we need a module which can emulate NVDIMM devices without relying on
> ACPI/NFIT.
>
> The emulated PMEM device is made part of the PAPR family.
>
> Corresponding changes for ndctl is also required, to add attributes needed
> for the test, which will be sent as a reply to this patch.
>
> The following is the test result, run on a x86 guest:

Ok, these kernel changes look fine to me. So, I'll go ahead and merge
these. The ndctl changes need the documentation update and the other
fixup about a generic way to signal support for the common error
flags.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
