Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E180DD0BF
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 22:58:48 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9195310FCB932;
	Fri, 18 Oct 2019 14:00:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7A2C010FCB92D
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 14:00:50 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id o205so6329455oib.12
        for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 13:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qdY8lKamoI89tjb/n2IZA34Mp2+ty5izzrijEhUlyUQ=;
        b=aIpmN8zW1vWOodd4xibe119Xivzb4h2Dnd6aijDcG/oIfQt4o/f6v+PYH2DhVNncNu
         wwEhQoyJbO2bOgr/kS/Ki22P5EprsN+/uIy4JsiM4EShb3fPCXrI7IezFK1ukIi5KSmf
         it7nNTeGwNXNsPbOCE/Kdrea8l4HYkxxYX4LSFS1M313CSnQ1h2s0AVj545FAiinyzSJ
         maoWCOhjF84c9g/C7VuFr/vDVx1IH2Sj7lvMq0zokLo+aMFS9+pip5lzYMI98y8D1jw7
         SyTzukn3ZD5cjebGMRcGajVnpMbYRc+U7wP3JvjhDord7z9JD627BqTi7wrr8Adv1rPO
         ZEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qdY8lKamoI89tjb/n2IZA34Mp2+ty5izzrijEhUlyUQ=;
        b=VsId0Bo8dD/WJ9er3tVKCHewnZM+vRarnlm1Z3HbSB9k+WugfnUhhabjXnwq9uspdt
         YuEfd0HOqAmtFH8OeSpJIO14CwC/pdrRJpwax/P7O0MrTF5vWF96ibwxLmlbLN8sG0Vy
         w5Rf3IGEo0oy2Sc3/ZQ+S4eHG1qegmLGqQjOm96Zixj7LrwwZ3wqTUwZulaDPaKAWl5L
         RFG1VNOhlMGjSmnvrHM4Cm4mL9NFtOyoje52gIfEciKChJtny5T8uyODb0ykkRErf5gL
         3+wwBnEwrRBpkulOSEvJVa7k7S3PdFpnN+5M5g1RDzrC/H2ivGHhKep3gJPa77bq0e0I
         yHag==
X-Gm-Message-State: APjAAAVUAJs11DFsg5R/sBkKHZvEZcpq7FOr7bl1Ub2enNNIK6gj2mCn
	drkO+NYLnUsJt9sR582nl/tS2ROtw161SbgvkmOE1A==
X-Google-Smtp-Source: APXvYqxy55+mH+LE8bOanH22BzqAQdEINrlbj0RYtpW7AL3cunSvQmjmF/O6HpXOmJruhf7lEwyC/G7WKVh8fC9oJLY=
X-Received: by 2002:aca:620a:: with SMTP id w10mr9962688oib.0.1571432324407;
 Fri, 18 Oct 2019 13:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191002234925.9190-1-vishal.l.verma@intel.com> <20191002234925.9190-11-vishal.l.verma@intel.com>
In-Reply-To: <20191002234925.9190-11-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 Oct 2019 13:58:33 -0700
Message-ID: <CAPcyv4hrxMFFK1wvCPkE1hMC8dyVFj3WUAzS4wgCBiuh0noa8w@mail.gmail.com>
Subject: Re: [ndctl PATCH 10/10] daxctl: add --no-movable option for onlining memory
To: Vishal Verma <vishal.l.verma@intel.com>
Message-ID-Hash: 5NFEP33ZMRGZHHLB43FOPJHA5GU3P2OU
X-Message-ID-Hash: 5NFEP33ZMRGZHHLB43FOPJHA5GU3P2OU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ben Olson <ben.olson@intel.com>, Michal Biesek <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5NFEP33ZMRGZHHLB43FOPJHA5GU3P2OU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 2, 2019 at 4:49 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add a new '--no-movable' option to daxctl commands that may online
> memory - i.e. daxctl-reconfigure-device and daxctl-online-memory.
>
> Users may wish additional control over the state of the newly added
> memory. Retain the daxctl default for onlining memory as 'movable', but
> allow it to be overridden using the above option.
>
> Link: https://github.com/pmem/ndctl/issues/110
> Cc: Ben Olson <ben.olson@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  Documentation/daxctl/daxctl-online-memory.txt |  2 ++
>  .../daxctl/daxctl-reconfigure-device.txt      |  2 ++
>  Documentation/daxctl/movable-options.txt      | 10 ++++++
>  daxctl/device.c                               | 34 ++++++++++++++++---
>  4 files changed, 44 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/daxctl/movable-options.txt
>
> diff --git a/Documentation/daxctl/daxctl-online-memory.txt b/Documentation/daxctl/daxctl-online-memory.txt
> index 5ac1cbf..08b45cc 100644
> --- a/Documentation/daxctl/daxctl-online-memory.txt
> +++ b/Documentation/daxctl/daxctl-online-memory.txt
> @@ -62,6 +62,8 @@ OPTIONS
>         more /dev/daxX.Y devices, where X is the region id and Y is the device
>         instance id.
>
> +include::movable-options.txt[]
> +
>  -u::
>  --human::
>         By default the command will output machine-friendly raw-integer
> diff --git a/Documentation/daxctl/daxctl-reconfigure-device.txt b/Documentation/daxctl/daxctl-reconfigure-device.txt
> index 4663529..cb28fed 100644
> --- a/Documentation/daxctl/daxctl-reconfigure-device.txt
> +++ b/Documentation/daxctl/daxctl-reconfigure-device.txt
> @@ -135,6 +135,8 @@ OPTIONS
>         brought online automatically and immediately with the 'online_movable'
>         policy. Use this option to disable the automatic onlining behavior.
>
> +include::movable-options.txt[]
> +
>  -f::
>  --force::
>         When converting from "system-ram" mode to "devdax", it is expected
> diff --git a/Documentation/daxctl/movable-options.txt b/Documentation/daxctl/movable-options.txt
> new file mode 100644
> index 0000000..0ddd7b6
> --- /dev/null
> +++ b/Documentation/daxctl/movable-options.txt
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +-M::
> +--no-movable::

If --movable is the default I would expect -M to be associated with
--movable. Don't we otherwise get the --no-<option> handling for free
with boolean options? I otherwise don't think we need a short option
for the "no" case.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
