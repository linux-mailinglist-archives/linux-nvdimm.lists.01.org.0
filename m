Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97495FA00E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Nov 2019 02:26:24 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 32A77100DC41E;
	Tue, 12 Nov 2019 17:28:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2DFDA100DC41C
	for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 17:28:01 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id 22so271121oip.7
        for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 17:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0MB/SSMpogQj4Fcl4IC+pxpUwq0gyFs7A/amSO1m4Y=;
        b=doPKvu1gZNpcuqwOmCORE1idu0dAD0+ZV4ybOrLIR70xlU/Ld+eQ7FHZDb7gjt5NSd
         uISrpZzkm2+LjEtMuDDLkKlB7O2X18chqvg8BtH28z3+X12qZdHaQHtuQushixLAzJg7
         t983ph1Tvk4oDHv2V/w4UkB4XE4huboN+gnSOdLM32WdvXQhALzflaDwdfqPOs4q1FDx
         KHTaYVXq5pc5+JMyRNtd4GCn8D2IdH6SpPmHk2S+B8emEa5gIX6d6TAhG7Nj1WNaSqx/
         ZxFw0h3C4SOkt6WE3U5FxbkudR4vKN1cP2Z3YTQ4vcdCMRuvF/2j35Cwczb+P1sv6s+B
         KzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0MB/SSMpogQj4Fcl4IC+pxpUwq0gyFs7A/amSO1m4Y=;
        b=ZrXpYy4Pj9bg3DhAy7N81o88xHMcbq5QcW1Vm9TVF+kfRi0/9t6NudIeUafVzlK5up
         WHuYQ1eDyxaUPhIzF+VrzJf5mYzEw//rarCVACWS3s/1OmghBIB1e4SYa5+M/rOv4ad2
         uvszs7ifhSmmmYfVD+JRLYqYs8rnc4XpUcNhG9pG8oKgKXhcqtdE3yPktO/Tx3ju5k/n
         W2CSW3i9WUnyEn+jzN5eROupsQXbFqVE1nV51TAG3JdNvTPavcvj5WgOU//bsPt5IwIZ
         Yn/nSWtQX/pqFP+ZDj5I6QhFJOyjGBhz7x2BTXOw/V6tLBQcN+tsLUr/nGuRWyJC3wkP
         b/MA==
X-Gm-Message-State: APjAAAWaFe+yAKI2ponR72m8HCucdT2hN0XbN06Jt998SkAXkCuXjQBs
	ql++NUxbODmftXLxZQB7emAkWfb9JVszTN0c2tKK9g==
X-Google-Smtp-Source: APXvYqxe6zvqvkMBezUGqzKAEYSTwQ/sNKuj6ffZfvcWwiO9AOk1SDdrnEGOgdcqBDW/SJNVakQKutXfNYK60w6drc8=
X-Received: by 2002:aca:ead7:: with SMTP id i206mr499780oih.0.1573608378184;
 Tue, 12 Nov 2019 17:26:18 -0800 (PST)
MIME-Version: 1.0
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157309901655.1582359.18126990555058555754.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87h839tpo9.fsf@linux.ibm.com>
In-Reply-To: <87h839tpo9.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 12 Nov 2019 17:26:07 -0800
Message-ID: <CAPcyv4gTRiZuA8A7cDxCZtHJv=LZMjd=tVgq35gbc0K8BUDHsA@mail.gmail.com>
Subject: Re: [PATCH 04/16] libnvdimm: Move nd_numa_attribute_group to device_type
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: NGWY3HX5LRQZT3LIT5RGUM226YKTU32L
X-Message-ID-Hash: NGWY3HX5LRQZT3LIT5RGUM226YKTU32L
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NGWY3HX5LRQZT3LIT5RGUM226YKTU32L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 12, 2019 at 1:23 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > A 'struct device_type' instance can carry default attributes for the
> > device. Use this facility to remove the export of
> > nd_numa_attribute_group and put the responsibility on the core rather
> > than leaf implementations to define this attribute.
> >
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: "Oliver O'Halloran" <oohall@gmail.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
>
> can we also expose target_node in a similar way? This allows application
> to better understand the node locality of the SCM device.

It is already exported for device-dax instances. See
DEVICE_ATTR_RO(target_node) in drivers/dax/bus.c. I did not see a use
case for it to be exported for other nvdimm device types.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
