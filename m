Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC71D39672
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Jun 2019 22:07:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D43F421290DFC;
	Fri,  7 Jun 2019 13:07:43 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B86AA21290DEE
 for <linux-nvdimm@lists.01.org>; Fri,  7 Jun 2019 13:07:41 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id p4so3016201oti.0
 for <linux-nvdimm@lists.01.org>; Fri, 07 Jun 2019 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eCiKEWFDcZP7j811fk8M8DkkVpOdsBHHGSCQGbcAqsM=;
 b=cX5B/ybN+9E76C8vJtaIyiZ12P5fTDIXvvmXG0mOyMhb/Md40OxzeycYBwXFnWA0IJ
 eHlbUUA10FvcMoJyZ8CTLDV9XHwhiUCX3OgHH81/Z7uy38VkIfuK665/O+t5F/pa0u8f
 QgcsAPD0wM+v2RvkhElbUU6b+LR29R1dqNkyno4eRZhIDtlQF/cFlGPX6xi1pTmSenIR
 RWyEjxRs88GDKPlo3xDEyPXchy6YBS7fEh0gh5qhe5t/i15+k6BZqVFzebLLrAceNQdc
 KYQQxtBe2uLzxpejgnrt3bWzxDBrq8tYDPjhi92QfxXzxDjAwak55hrZX6LaF12G9aHE
 srjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eCiKEWFDcZP7j811fk8M8DkkVpOdsBHHGSCQGbcAqsM=;
 b=DG8FPNWlWw+C9OlRN+Z6g+8w3Bch8m6yJsrSOSN5IYsMO4Bk9LdyMNOrBXd8m2AflZ
 quZzfcpxS/A0p0l/1AGvBTTRZLuNxB7O1JqodmeFOvAkDz6K7b5t++tqfI5/YixKo76Q
 iY97K1hEgZ+8v9aAF3j1k04LpVi1qxj5vSFlDVw9xcQ6T+n2z+9jdlcNpWDLGucEqW72
 H4b/6su7tf3h0Om7/H653NCtpBL8V6XmU5ba/W37pTqTb0aOeMvjNxe+rfGXsYU7rVR3
 8KHeBa4vrQJWWATD9L62M340BfdWK4GY20r4WcLQtiBPzrAZkdjsta28dMaSSZG0Tj4v
 IvvA==
X-Gm-Message-State: APjAAAXVx0S0EBWwTU3g7flfAQzPMekzwpK9DGXre6q9YnL8uHSvvkJS
 V0gOVCSgoJDxp9Ahimy4ccEzPbiyp3JG37MwEotdXA==
X-Google-Smtp-Source: APXvYqz2rbY6yUyrAbyzCD+KOoV/chSruHULmHuQow0UVyDGQb5c3BZJ2KdwaL++9IlM9uuK2zqoXUgttHphpe1xf4A=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr15801599otn.71.1559938060915; 
 Fri, 07 Jun 2019 13:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155993567538.3036719.16306480832003017141.stgit@dwillia2-desk3.amr.corp.intel.com>
 <e2fd563a-1be4-b4dc-09fa-886f0319be5b@intel.com>
In-Reply-To: <e2fd563a-1be4-b4dc-09fa-886f0319be5b@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 7 Jun 2019 13:07:30 -0700
Message-ID: <CAPcyv4jhoxDXUwv4vgDYo=aLAAOxZ-Yq0qcgi5kHF_ybGUd-gg@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] device-dax: Add a driver for "hmem" devices
To: Dave Hansen <dave.hansen@intel.com>
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
Cc: X86 ML <x86@kernel.org>, kbuild test robot <lkp@intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 7, 2019 at 12:54 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/7/19 12:27 PM, Dan Williams wrote:
> > This consumes "hmem" devices the producer of "hmem" devices is saved for
> > a follow-on patch so that it can reference the new CONFIG_DEV_DAX_HMEM
> > symbol to gate performing the enumeration work.
>
> Do these literally show up as /dev/hmemX?

No, everything shows as daxX.Y character devices across hmem and pmem
producers. For example:

# daxctl list -RDu
[
  {
    "path":"/platform/hmem.1",
    "id":1,
    "size":"4.00 GiB (4.29 GB)",
    "align":2097152,
    "devices":[
      {
        "chardev":"dax1.0",
        "size":"4.00 GiB (4.29 GB)"
      }
    ]
  },
  {
    "path":"/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/region2/dax2.1",
    "id":2,
    "size":"125.01 GiB (134.23 GB)",
    "align":2097152,
    "devices":[
      {
        "chardev":"dax2.0",
        "size":"125.01 GiB (134.23 GB)"
      }
    ]
  },
  {
    "path":"/platform/hmem.0",
    "id":0,
    "size":"4.00 GiB (4.29 GB)",
    "align":2097152,
    "devices":[
      {
        "chardev":"dax0.0",
        "size":"4.00 GiB (4.29 GB)"
      }
    ]
  }
]
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
