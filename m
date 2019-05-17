Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 783BC21A90
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 17:31:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7521121275462;
	Fri, 17 May 2019 08:31:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 94EFB21CB74A4
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 08:31:03 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id p27so11209418eda.1
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 08:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o+nSlUDg8BrFt3rDs8b+CCqHMgbT+SghNKN3HnpgGGI=;
 b=ZAy1uX60oSFmzO3f13BCtkZJ9U2KdaKWgLCJnkwdwNW33ikMRdL1nvGKLSc+e7JACb
 oFNgulvpxMxsrkiNvb1AodwESeV+rKXnOqjrYuG9wZaM7woCP6RxeROMlCYe0insp2cr
 GJmPqb9AHUOiL7YDe8k4Wx3pJ/29XqZq24XH/R4nwd3c3tEZKBqV8DbTeaGhesl95iY3
 EJB8mpEh5sopSKDtk90RxzVzKD439bZojih/tXZ3pFu3vrWKSOW2K3S649obqmkiq1Tv
 CbqRWdVSM1+xKpMElUBmAkOY4c/JqR8NqyPNiFxYRM1jh+3kBu2Qhihlc6PNaHsh3bmc
 K8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o+nSlUDg8BrFt3rDs8b+CCqHMgbT+SghNKN3HnpgGGI=;
 b=T/9RKkRt200rSMmmGH8v/Qv1lRibogsFgrqTjHoC7itx/uHLD57vfB0xvKr0z8Pc8K
 XC2zha3PMAShELQInvdoF5Yu3CGMBFY/9al3XYfBsCpIO7CtDJOgM7ajowaJ2/nc7XBl
 s504dOQBE5JkemNMiArwb7diEL63S+lVTVpeIO2ErR3I60TWKNspzqC8YnEVLM/za1t2
 f2shFej7NPD+VcC+dzDI9v5vBi582TUAE+6qaiQcJAXWBegRHieEbzCi2gzGikFa0JIt
 6o8iodizr6oBkMK7D+n2nwyWGGQVV0g5Z99Wtvj6Q1cF8ygN4hA7xdC0wSONjGPiv+N6
 OC0w==
X-Gm-Message-State: APjAAAXn5aoaNufzidmrOuxw/QAvKNrjjs50idd7XxldLPZ7AGI36t5S
 LtIEd4CTjtLlGv2kkvOPXCTy3SQ9S4pW4HQbc2/cQg==
X-Google-Smtp-Source: APXvYqwXwfODEALGJFuNb3W4QPfr/h9bVR7PcifmjL3UGnN06dJDZ3z2obJpMmwiJzWB5jdtFFnrIQ5//ggESmGeztk=
X-Received: by 2002:a50:ec87:: with SMTP id e7mr57884860edr.126.1558107061728; 
 Fri, 17 May 2019 08:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190516224053.3655-1-vishal.l.verma@intel.com>
In-Reply-To: <20190516224053.3655-1-vishal.l.verma@intel.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 17 May 2019 11:30:50 -0400
Message-ID: <CA+CK2bCEUjCNGHcfqh+4gxtf80eUkz_swNny6A2mkJwLi6Yn+Q@mail.gmail.com>
Subject: Re: [ndctl PATCH v3 00/10] daxctl: add a new reconfigure-device
 command
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
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, May 16, 2019 at 6:40 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Changes in v3:
>  - In daxctl_dev_get_mode(), remove the subsystem warning, detect dax-class
>    and simply make it return devdax

Hi Vishal,

I am still getting the same error as before:

# ndctl create-namespace --mode devdax --map mem -e namespace0.0 -f
[  141.525873] dax0.0 initialised, 524288 pages in 7ms
libdaxctl: __sysfs_device_parse: dax0.0: add_dev() failed
...

I am building it via buildroot, and can share the initramfs file or
anything that can help you with fixing this issue.

Thank you,
Pavel
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
