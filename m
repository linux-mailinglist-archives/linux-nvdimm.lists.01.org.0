Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367A92D39D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 May 2019 04:13:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5EDA32128DD2C;
	Tue, 28 May 2019 19:13:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 43FEA2128DD24
 for <linux-nvdimm@lists.01.org>; Tue, 28 May 2019 19:13:39 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w144so731556oie.12
 for <linux-nvdimm@lists.01.org>; Tue, 28 May 2019 19:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ooLmbDwh5MaStJr3+UfHuQNUX9PmXkrMKgP2BAn7Aas=;
 b=jKAUrzFnk3RSXOVlfzdLPEDwV/KPXsJ3eaYNRJJIESNQq6A1k70qCvrEPeVN7XEYqv
 9MC1csYPfGO2nt8FNBwhMdQqLQZ6n3fU/qVYg9HDP5RkGanD5OiufpyUkGD8JLA4K+u2
 XLsCxqhEh/AVtr+5A1Ws70JIWrCcVwWZyJw/14K5S7wJGy+216CMQ+cCASHehawxF3Z1
 L8p97NIorGtRST1KTu17a8L8qX1hNBgtcXnasFrhO5inJm4UJPzKffSv33m8o7GUmOie
 211zrDrAKGn+wZ4xg8brQ6xQALAjoyNRtFRybRfzWAP9gDWtGZlq2HTBZHtt6orGulAx
 EM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ooLmbDwh5MaStJr3+UfHuQNUX9PmXkrMKgP2BAn7Aas=;
 b=QcZvoOXUHdCMISL98M7p2IsWLpzUrLSn+6qZM6yDKnmdpEffp00NQ8RXd3OgPpwGb8
 VCjwSyz3B2OZKwtkpFumPchqQXW97nhUcD+mqIoHJr7ZCkj/Wsdip1UbpCwUThSnhyja
 c3QP9CoTg4L6f062+Ym2P47xWPMvzWnDYXbxHBW1USHweDFSoLiYodRuptSsexV7czQW
 f3qSh6YYajmmUGn/23j1gpG3zNYQxgA5KzRn7a7n338NKaMcRdsLLZerK9N6qKdcEO/8
 bCfpfs509MdfGDZjTw/XBeJjWvC+4wPLEyOhx0P/OBk6CuUg4hoBu9gEMZ68qPPUZW/K
 a7XQ==
X-Gm-Message-State: APjAAAX6aOolp7beHHEUkghPQvm2kpE+MmjWHRa2P1FLSe7/Go+IbqXT
 nP+FzXUpfq5KmxqH6yCHXQk6gMrBU7wy9zcJy8X9Rw==
X-Google-Smtp-Source: APXvYqy30HhJafGReGrBFRlBS9Ds+x6szLqY9E9IK9zUU4wYexQj0GBwqPIrda+uitgxNEuADCRNmBotnPTNzsFcmOw=
X-Received: by 2002:aca:b641:: with SMTP id g62mr4916230oif.149.1559096017979; 
 Tue, 28 May 2019 19:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190528222440.30392-1-vishal.l.verma@intel.com>
 <20190528222440.30392-4-vishal.l.verma@intel.com>
In-Reply-To: <20190528222440.30392-4-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 28 May 2019 19:13:26 -0700
Message-ID: <CAPcyv4hsk66TBg-6V_quSHpZ7fx8S3tu8i4-30nwHoGvSMsZZw@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 03/10] libdaxctl: add interfaces to
 enable/disable devices
To: Vishal Verma <vishal.l.verma@intel.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, May 28, 2019 at 3:24 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add new libdaxctl interfaces to disable a device_dax based devices, and
> to enable it into a given mode. The modes available are 'device_dax',

Does this mode name get exposed to the command line interface? If
"yes", I think this should be 'devdax' to match the ndctl namespace
mode, or just 'device', but otherwise no "_" in any command-line
interfaces. Otherwise I think the module names are an internal
implementation detail of the kernel ABI and need not leak further than
the libdaxctl to kernel interface.

> and 'system-ram', where device_dax is the normal device DAX mode used
> via a character device, and 'system-ram' uses the kernel's 'kmem'
> facility to hotplug the device into the system's memory space, and can
> be used as normal system memory.
>
> This adds the following new interfaces:
>
>   daxctl_dev_disable;
>   daxctl_dev_enable_devdax;
>   daxctl_dev_enable_ram;
>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
