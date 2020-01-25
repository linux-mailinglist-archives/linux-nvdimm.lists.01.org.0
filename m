Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF401492FD
	for <lists+linux-nvdimm@lfdr.de>; Sat, 25 Jan 2020 03:22:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D86F31007B1DA;
	Fri, 24 Jan 2020 18:26:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6BA771007B1D9
	for <linux-nvdimm@lists.01.org>; Fri, 24 Jan 2020 18:26:11 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id g15so3539680otp.3
        for <linux-nvdimm@lists.01.org>; Fri, 24 Jan 2020 18:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/n8lF7sB/G0OJ47h6UoXFZCKXAR8cfzClzKuajS7jxM=;
        b=vaEoZ08oR7N9T1Q8AnwpSBgU5DvAOngrVikksVYErSbIeuEcDqlHKppy72c7yIhy3n
         6qjQZsztL7I9e3LFH1uJmIaRmcttc8kEu0cCtXdgchriXFUra3Ljf3Z2YVbS/EoPKBpO
         ROZwfbvirB3CO+/vs9UFPBNtke1+iKXopmA5lE5d6gSXLJ30rWT9A7zztrkY2JywG1Ca
         +CT3KB/qGD9/J5I+cPmgQ6T/q+91uSM45RsYjCtOzuy5bRRpOwddvcs63kz15oDshUhz
         14bP2Y5k3Ylx/RfHpn30OqySVirLH1GfcF5h6hBMIA7FZHhBVzU2gYouR8TI3F6GBkdB
         /3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/n8lF7sB/G0OJ47h6UoXFZCKXAR8cfzClzKuajS7jxM=;
        b=qc+gOk5GWpegLTO4OOCymO3Sgt9qN73DI/ivw2W4QtTdjVK3qhnjAY4Pranxhtbc16
         1YFja25CIRu8VzrJrInSK/QQOvwPBAwOJ0TyxnBM92/KIU+BD8YES8wMqJ9+xKelS5eb
         qiGw8JloB39d/v2uaxf1uSTUYALfC4GK5oqeGcl19ZrmXCCPjtn1+CnQ8H99rVNXhT3k
         OOFuz9MvHUKgm0ahPJDKinEneuR+0Tjf7Q5SV2J/73EO6GCGEG6PBbYviTr5QA0vhgRR
         Tu8cWn1colJKT2hASA3tyhpK9qlZcZMLtRq7Np+Yr5g1eYT0kiaP6j0cyxZ+rfW95U4i
         aTKQ==
X-Gm-Message-State: APjAAAXXpIWILwiPiwCFCRKMqAkeetGkt0HMPVrC6/W+NZPmd5lLqhLD
	+n+qLwgwK33B+5Vt2vY//Ap3R1T4lCn/Uo5X4BCMc+yVPaQ=
X-Google-Smtp-Source: APXvYqyzHZRAnlkCINEH/CF8DNJqmqXr7N8p3VosXpk6A2YnXWsRxaO3xwmzkMI1GJKtzmpzX6/8jznFukfZ3oMujzU=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr5149084otk.363.1579918972486;
 Fri, 24 Jan 2020 18:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20200120140749.69549-1-aneesh.kumar@linux.ibm.com> <20200120140749.69549-5-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20200120140749.69549-5-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 24 Jan 2020 18:22:41 -0800
Message-ID: <CAPcyv4gzzjdLtH_Tx=d9cW8wEhWBVBv8TFRwCOFn+YfyJvO4ug@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] libnvdimm/namespace: Validate namespace size when
 creating a new namespace.
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: 73UNZXIWCTYPYAS3YBPNGJE7D5272FSU
X-Message-ID-Hash: 73UNZXIWCTYPYAS3YBPNGJE7D5272FSU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/73UNZXIWCTYPYAS3YBPNGJE7D5272FSU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 20, 2020 at 6:08 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Kernel should validate the namespace size against SUBSECTION_SIZE rather than
> PAGE_SIZE. blk namespace continues to use old rule so that the new kernel don't
> break the creation of blk namespaces.
>
> Use the new helper arch_namespace_align_size() so that architecture specific
> restrictions are also taken care of.
>
> kernel log will contain the below details
> [  939.620064] nd namespace0.3: 1071644672 is not 16384K aligned

This can't be enforced at size_store() time because the size is only
invalid relative to whether someone wants to create more namespaces or
assign a personality. Instead the free space allocation code needs to
pick the correct alignment by default, and it needs to assume that the
boot-to-boot physical address alignment variation is something greater
than memremap_compat_align(). For x86 it's typically 64MiB, do you
happen to know if Power firmware would ever physically remap a
resource range in a way that would violate that 16MiB minimum
alignment guarantee?

If we have that guarantee then the new kernel enabling needed is a way
to adjust the free-space allocator to align new allocations to
memremap_compat_align(), but that ndctl would likely bump that up to
16MiB across the board since it knows that Power needs more alignment
than x86 and it is the agent that wants to enforce cross-arch
compatibility. Otherwise the kernel should do it's best to support
requested size_store().
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
