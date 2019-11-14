Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6DEFCACD
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 Nov 2019 17:35:21 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6B64F100EE8CE;
	Thu, 14 Nov 2019 08:36:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 46C4C100EE8CD
	for <linux-nvdimm@lists.01.org>; Thu, 14 Nov 2019 08:36:47 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id l14so5371206oti.10
        for <linux-nvdimm@lists.01.org>; Thu, 14 Nov 2019 08:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNGw4TfqpfUCJ1fFVpttb7yfMciDUeoomP1skmq9jqo=;
        b=wzDdYVXqT4Ey6M67cJpE2V9RW05xslTchPTS/hgQLgzS1Adyn/SSVZe8h+/FV3+OEr
         52aw9+G2ykaRfJ+mRf/qS93DqP/b1+Z7BIrrOLGGb96L9dS13FR/cQ5cJs76bWWlrK6W
         fqNBszqmuQdRuM/2GYczu5lSzGyKaI9xXrl4V/ZNMXYZfWwpYAi0lOB/oV28HZ7TjStS
         Zqfj2Avr6iBAu3jFnq7z/TQ870HCPlT3y93YEl4aHjCjK+JNpENeUdIZtSkOrBX6im9e
         w+lAIM11QP6vdr3x7EMoEeyf6fIy5ZiIpMHQUXkqsZwsodfqmPUjwrQgkGmNxSc/hft5
         YFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNGw4TfqpfUCJ1fFVpttb7yfMciDUeoomP1skmq9jqo=;
        b=l0z9Ew2RRh3UR6GGyjzQiObewojzSQdxYvtMcXuoiUOg2kwjtA2iokghguWu20oIOV
         Qmhjtog3oH4Nr4C9ooFzaqR0WiZfV24WkJ1Yj3e27TsSIbVOQMVMVwbrWCPzsKMYIR1l
         xmCBSnB0g0J3Ox0o+tGkU09jJSCGL1txRqc7p/a+qmFZi1rfeRUvfvwK/HekV3nlvqAi
         bj+1n6jyC+CVkLlMMHEecav1VCV226dvpNiJXb0rD4lSnD9TewRFFIOjgsYtlp7i+cEc
         5RNKH2RgFicBqcbR2xy37QYnhJxMmsttPKxVUixdLvNKTIKaHadksFZHgWKk8NobMP2z
         /Hvg==
X-Gm-Message-State: APjAAAXFUI9iD1e+Q1VaTqKjjTaOjCVh4okhSGmPLv6i/5e2xI8ahQS2
	s23mStJtcvEAtcvjcQSsthVZeKjLq7tsW3uUeU6+Og==
X-Google-Smtp-Source: APXvYqwhlbMIqVoDMtemn28FjHxtHG8v5mkLAQT8X9GpCHUizz0JFqeybR7UBBP0zJO9mCY12klfr97VHx+i97m3uhU=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr7713217otb.126.1573749316381;
 Thu, 14 Nov 2019 08:35:16 -0800 (PST)
MIME-Version: 1.0
References: <20191025044721.16617-1-alastair@au1.ibm.com> <20191025044721.16617-9-alastair@au1.ibm.com>
 <8232c1a6-d52a-6c32-6178-de082174a92a@linux.ibm.com>
In-Reply-To: <8232c1a6-d52a-6c32-6178-de082174a92a@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 14 Nov 2019 08:35:04 -0800
Message-ID: <CAPcyv4g9b6PyREurH9NcQf4BO2YcRGJPBZDqGKy-Vz91mBKjew@mail.gmail.com>
Subject: Re: [PATCH 08/10] nvdimm: Add driver for OpenCAPI Storage Class Memory
To: Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID-Hash: U5CRDAG2YMT7XY4B5A7P7XCWSXXGLBY3
X-Message-ID-Hash: U5CRDAG2YMT7XY4B5A7P7XCWSXXGLBY3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Wei Yang <richard.weiyang@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Qian Cai <cai@lca.pw>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Hari Bathini <hbathini@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Linux MM <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-
 foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U5CRDAG2YMT7XY4B5A7P7XCWSXXGLBY3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Some quick feedback on your intro concerns...

On Thu, Nov 14, 2019 at 5:41 AM Frederic Barrat <fbarrat@linux.ibm.com> wrote:
>
> Hi Alastair,
>
> The patch is huge and could/should probably be split in smaller pieces

Yeah, it's a must. Split the minimum viable infrastructure by topic
and then follow on with per-feature topic patches.

> to ease the review. However, having sinned on that same topic in the
> past, I made a first pass anyway. I haven't covered everything but tried
> to focus on the general setup of the driver for now.
> Since the patch is very long, I'm writing all the comments in one chunk
> here instead of spreading them over a few thousand lines, where some
> would be easy to miss.
>
>
> Update MAINTAINERS for the new files
>
> Have you discussed with the directory owner if it's ok to split the
> driver over several files?

My thought is to establish drivers/opencapi/ and move this and the
existing drivers/misc/ocxl/ bits there.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
