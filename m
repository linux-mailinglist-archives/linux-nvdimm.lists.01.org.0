Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7052E9F65
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 Jan 2021 22:16:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7E698100ED49C;
	Mon,  4 Jan 2021 13:16:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AE089100EF24E
	for <linux-nvdimm@lists.01.org>; Mon,  4 Jan 2021 13:16:40 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id j16so28865840edr.0
        for <linux-nvdimm@lists.01.org>; Mon, 04 Jan 2021 13:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mnKfDoOx66q+e0Lit8qASXnCRcAau0LZz1jjX0h1mMI=;
        b=x0BSXLxek3pk4fU9rjITIby4RDN/i8u1yc0iV63Y5fN9t7XNJXFugUhQOZvRBa3/fT
         NnzRZk70xlC+v0AS8i8Q8U1oM1Q4jUN1WaIXy0yVxUmr8CigRBuTYiYiD77cw7XnRYNg
         AQKYFOj0t8fBVjqhQiRJQ46xXdZ5qccMBRQJc6lQ2lfc8JxFlw8kWo41PnUbzJXKgKQJ
         LMaDkFKRqU8+zMd6ddthox1+O1Z4gr702uksqYFDObKideo8vx80vIc2wbO5d9qyuZX0
         +oXmDJyRQTooHxJc8tIjRllxlq96HkSdCfB+lJxuM8LjKp/spy01Y2gJSSlL4Xkg7pIJ
         ni0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mnKfDoOx66q+e0Lit8qASXnCRcAau0LZz1jjX0h1mMI=;
        b=GenW4s5KOMd/PyHwIXkLT9sqImvnuv5gaI8it7mpLNbDABCPx4MdzoHyoq9tsGfE0X
         vXH9yvY5018VDU3T+fhMJh0n3kpvzL1O1Xjj+Vkj1Ik2KUuZpfp2GpfpIFNjYVR8P4MM
         +EIDl8TMwl61CduQ4Ljhh2fhu9liimSDFGFZKRs9WtVfgQDiNgQUKIcWlohzZh5tp5b/
         ov5VLNsA0LUx+VP1EtawXWv19n5VUOwbXrkhpS1AwsNJ9DHf6issc8LFMr8OGOdpgjQH
         tAEqb8V+iDoydNFtk0dbzXLT/tg/NrcGdIRG8LlpThx+KmswOvSdmPXHTBmUZbd8d6gM
         VBYg==
X-Gm-Message-State: AOAM533D1G5tEPr3MglxefHRlM/rdGpLaha8Q4jW03rbuy/u5JiL/u0x
	5lw1K5OeYQhcAzPiMd4y/5+E71NNs773A4bG/rQRcA==
X-Google-Smtp-Source: ABdhPJzSFrzuW35He0bT4+4PgVeyKK9P6is8Ha/LA4Q6+q+RoJA0p/dFoXCcETkeECxmCu8v4jPf+Zd92V0ZF9ZMODI=
X-Received: by 2002:aa7:cdc3:: with SMTP id h3mr17778068edw.52.1609794998256;
 Mon, 04 Jan 2021 13:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20201225013546.300116-1-jianpeng.ma@intel.com> <20201228171758.GO1563847@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20201228171758.GO1563847@iweiny-DESK2.sc.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 4 Jan 2021 13:16:32 -0800
Message-ID: <CAPcyv4gm-CnOAYqNYL29TUCQF04f9uCQOgF1ndRpu=_7e6T_kQ@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/pmem: remove unused header.
To: Ira Weiny <ira.weiny@intel.com>
Message-ID-Hash: BQU6BS2KWU6LUBHQBENCLGNMECH27SVK
X-Message-ID-Hash: BQU6BS2KWU6LUBHQBENCLGNMECH27SVK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jianpeng Ma <jianpeng.ma@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BQU6BS2KWU6LUBHQBENCLGNMECH27SVK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Dec 28, 2020 at 9:18 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Fri, Dec 25, 2020 at 09:35:46AM +0800, Jianpeng Ma wrote:
> > 'commit a8b456d01cd6 ("bdi: remove BDI_CAP_SYNCHRONOUS_IO")' forgot
>
> This information should be part of a fixes tag.

Oh, I was just about to comment "don't provide a Fixes tag for pure
cleanups". Fixes is for functional issues that a backporter should
consider.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
