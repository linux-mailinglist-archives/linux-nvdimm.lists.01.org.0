Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A0E112126
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Dec 2019 02:50:41 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 91A35100DC41F;
	Tue,  3 Dec 2019 17:54:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 72156100EA543
	for <linux-nvdimm@lists.01.org>; Tue,  3 Dec 2019 17:53:58 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id j22so5348649oij.9
        for <linux-nvdimm@lists.01.org>; Tue, 03 Dec 2019 17:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KXwGPP+fUHeViCe/FDfNYchSX6oteeHrIUnC2gWR7g=;
        b=QkoA4lrtLLkyNd5eSUds3cU5/n4bkn7s5T+kLevBOvIX5uKVVxCMkdso1ZeARkeelS
         ldPnB8URrdIhZXN6ZTS5KIOqDmD7u5jX5sVBCOUVgMTejHNDbvkMZjW9NMGBOCFqE/tV
         X25BHq2VR6mH8ffhqfNfqgy/G3HLSxpbBzdp5g3bqnfuHIZt1wKlFo9v5jw8MXnRZ+2g
         IyvuY6fqoZA+paT76n9tOtIp7ssew215+u/uk7RGNP4qyxJzOyDXcr7S0qDPZgrS7Tap
         uXkTwh8IBwwet3304IipX6f3gF3qoNrFvks+rGvkUXgyRXxgvcFrWrzPKPumg3p9A8Tx
         Iz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KXwGPP+fUHeViCe/FDfNYchSX6oteeHrIUnC2gWR7g=;
        b=ckePoRElggOW8DSsnu4KrE49GOPq2HSG9rUK/h+TKHJ21vDq0oVpqxJrwZZkilFPIv
         fBmpDEEgEKIzG+yknHKAdzF/rS2gtylZU6oY1vQ/u5wxd89SPl3RiWCu/PFA/QJspvBC
         HK1yJhbCMePr7mhoP4oddClocIL/rE/xZ6o4goM0d87opMaM3i4Ol7mqyK1kd4lcirc0
         sQmmTgk8KtkiNMA4sn1jxUrsMu3BrhUinvOwe3WVmYhZB5xOIxOFbJqSGTQ1mZKNxcrx
         ViFtQ3JCY0U9wxKBoACI+++S9hNmjJmRIqgnVTma1Zj6Bfy2lCYYhNCBm6pwSyrWMgeb
         9v6A==
X-Gm-Message-State: APjAAAVLYW20BrNzx01L6rRIny4fL0v2zc1V9Cx4xgEpasnCewCFRCm2
	gATL3izlImEqxx7z4emvNhbiD5A8YMSqd862ZBNBTuiz/HU=
X-Google-Smtp-Source: APXvYqyPMwN2Zi9EDPsfLCUx3R2ZjF3NkFJh8KSugiFa5rAwxRZaPEb+zE1NKHHRCdJ88EosBPrp2mzyIbxCWDunClk=
X-Received: by 2002:aca:2405:: with SMTP id n5mr619556oic.73.1575424235702;
 Tue, 03 Dec 2019 17:50:35 -0800 (PST)
MIME-Version: 1.0
References: <2369E669066F8E42A79A3DF0E43B9E643AC95A81@pgsmsx114.gar.corp.intel.com>
 <CAPcyv4gvih=YwGcuDs8M168kAq3Skp8khq6QDRq8ju-S_sL_Nw@mail.gmail.com>
 <2369E669066F8E42A79A3DF0E43B9E643AC9B3DA@pgsmsx114.gar.corp.intel.com> <2369E669066F8E42A79A3DF0E43B9E643AC9DC32@pgsmsx114.gar.corp.intel.com>
In-Reply-To: <2369E669066F8E42A79A3DF0E43B9E643AC9DC32@pgsmsx114.gar.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 3 Dec 2019 17:50:24 -0800
Message-ID: <CAPcyv4jDGSfQSfiLEyP8KDMd=g3fL4S0FZFjgptnp+y5L+kB1g@mail.gmail.com>
Subject: Re: daxctl: Change region input type from INTEGER to STRING.
To: "Li, Redhairer" <redhairer.li@intel.com>
Message-ID-Hash: UYRLERSPRDJR4SDIMZIY36RMGZEZLKOL
X-Message-ID-Hash: UYRLERSPRDJR4SDIMZIY36RMGZEZLKOL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UYRLERSPRDJR4SDIMZIY36RMGZEZLKOL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Dec 2, 2019 at 6:43 PM Li, Redhairer <redhairer.li@intel.com> wrote:
>
> I have squashed my previous two change.
> Please refer it.

The logic looks good, and it's passing my manual tests. However the
unit tests are currently failing, so I got sidetracked trying to look
into that. Not your issue, but it prevented me from responding right
away.

As for the final version of the patch:

The changelog grammar needs a small fixup. How about:

"
Allow daxctl to accept both <region-id>, and region name as region
parameter. For example:

    daxctl list -r region5
    daxctl list -r 5
"

There were some whitespace errors in util_daxctl_region_filter()
(indentation for a continued if statement and missing space around
"=="). You can use vim's default C identing.

It also needs to be resent as a plain text patch, not an attachment,
otherwise patchwork won't pick it up [1]. For this first submission
you can send it again as an attachment and I'll resend to the list.

[1]: https://patchwork.kernel.org/project/linux-nvdimm/list/
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
