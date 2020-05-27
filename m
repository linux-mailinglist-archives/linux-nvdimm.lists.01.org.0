Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EF61E4D81
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 May 2020 20:57:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 52AF012263AF7;
	Wed, 27 May 2020 11:52:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9857E1225B0A6
	for <linux-nvdimm@lists.01.org>; Wed, 27 May 2020 11:52:44 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id bs4so21185506edb.6
        for <linux-nvdimm@lists.01.org>; Wed, 27 May 2020 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhcFFsKj7N+XV8AMHJECIG5DAX+f8KJohJMbtgsnPKk=;
        b=AFDSD49cFylraLBD8OCsBvKLCgfANQjtXQzpSAYlTF6Rv8Dyagb3TLPZK1G4myVkYi
         cgrEWZNeCtmNDURPKDi156IaV5KGpxIVtFJq1iysfivwJJn+Hqk6RHU+hxBMeGeHJItx
         qrrdgEi8Tk4gM7dnw9RHhVlFwcE2Vs4DRPoYlcHOd8rW8L5cDBPOhMKneNPwniAKfSoM
         qYrZxyEpn9GeZhMDVEie/I+AKvGmV+tKYBTpLQA06+dcCFjFFUriCuv45ObESJGVixQn
         O0UBFJhYwsMUNrOWlOLZBzc8n/Ci/6z3XT8+LU0DgS8TI1HKkWmsED5ysHTFpPNc2+eC
         /iJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhcFFsKj7N+XV8AMHJECIG5DAX+f8KJohJMbtgsnPKk=;
        b=EwwoKKAfIK63i8dh4nlI5rWLqrx72+q855thv3KKi1/1f93nv2k7MczmzsGs7IiyPH
         d+09P2EQ5SMb8JCt3D35FQTO16AmmSkVSBHO71Lr3mXVBz0mEiY6EANhOZGjxSxd/vnA
         ci3aW6TCifvzwpfdLTyV4PmQ7qjJCgvsD7/OKSwatrHE8c2tJmxVPsN+RlMZl+Xp9XVJ
         jORSg8fFtyJTLrEl9P4OnyN5fNyBuB2aDdaP2mc03KogDDVFH8IZPbTxQeYfr1tFFgoG
         6FnE5jpC057tA06c3QevvMyn2j+QJjs8d0zHVcuVSt4IXZcv3nP3HpfbKB7OpIe8PNpn
         SToQ==
X-Gm-Message-State: AOAM532jvpYkPNT7uxXTEeTfqIaeNTKK+tRP4KZY3wfCbdOaqGA8NBS0
	07ttEsybswIvVtUUcWCiDgq/2VCUWCEyaXiHYBW7Ng==
X-Google-Smtp-Source: ABdhPJwI+ATlYbLOn+OYCZPcy6MrH5Uw8AiuZ7BVCw67ST1mkLWvplIHlYCQn8Tp39Sljyhjk/Tm+0wSN17kQ6/Jzk4=
X-Received: by 2002:a05:6402:1c1e:: with SMTP id ck30mr24473373edb.154.1590605815518;
 Wed, 27 May 2020 11:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200527041244.37821-1-vaibhav@linux.ibm.com> <20200527041244.37821-2-vaibhav@linux.ibm.com>
In-Reply-To: <20200527041244.37821-2-vaibhav@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 May 2020 11:56:44 -0700
Message-ID: <CAPcyv4jXp1FocSe-fFBA_00TnsjPudrBCuHBfv+zwHA_R0353A@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] powerpc: Document details on H_SCM_HEALTH hcall
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Message-ID-Hash: DDHI7RURVOWOYLHPXE5UQMVMSQHLGPEP
X-Message-ID-Hash: DDHI7RURVOWOYLHPXE5UQMVMSQHLGPEP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DDHI7RURVOWOYLHPXE5UQMVMSQHLGPEP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 26, 2020 at 9:13 PM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Add documentation to 'papr_hcalls.rst' describing the bitmap flags
> that are returned from H_SCM_HEALTH hcall as per the PAPR-SCM
> specification.
>

Please do a global s/SCM/PMEM/ or s/SCM/NVDIMM/. It's unfortunate that
we already have 2 ways to describe persistent memory devices, let's
not perpetuate a third so that "grep" has a chance to find
interrelated code across architectures. Other than that this looks
good to me.

> Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
> v7..v8:
> * Added a clarification on bit-ordering of Health Bitmap
>
> Resend:
> * None
>
> v6..v7:
> * None
>
> v5..v6:
> * New patch in the series
> ---
>  Documentation/powerpc/papr_hcalls.rst | 45 ++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/powerpc/papr_hcalls.rst b/Documentation/powerpc/papr_hcalls.rst
> index 3493631a60f8..45063f305813 100644
> --- a/Documentation/powerpc/papr_hcalls.rst
> +++ b/Documentation/powerpc/papr_hcalls.rst
> @@ -220,13 +220,50 @@ from the LPAR memory.
>  **H_SCM_HEALTH**
>
>  | Input: drcIndex
> -| Out: *health-bitmap, health-bit-valid-bitmap*
> +| Out: *health-bitmap (r4), health-bit-valid-bitmap (r5)*
>  | Return Value: *H_Success, H_Parameter, H_Hardware*
>
>  Given a DRC Index return the info on predictive failure and overall health of
> -the NVDIMM. The asserted bits in the health-bitmap indicate a single predictive
> -failure and health-bit-valid-bitmap indicate which bits in health-bitmap are
> -valid.
> +the NVDIMM. The asserted bits in the health-bitmap indicate one or more states
> +(described in table below) of the NVDIMM and health-bit-valid-bitmap indicate
> +which bits in health-bitmap are valid. The bits are reported in
> +reverse bit ordering for example a value of 0xC400000000000000
> +indicates bits 0, 1, and 5 are valid.
> +
> +Health Bitmap Flags:
> +
> ++------+-----------------------------------------------------------------------+
> +|  Bit |               Definition                                              |
> ++======+=======================================================================+
> +|  00  | SCM device is unable to persist memory contents.                      |
> +|      | If the system is powered down, nothing will be saved.                 |
> ++------+-----------------------------------------------------------------------+
> +|  01  | SCM device failed to persist memory contents. Either contents were not|
> +|      | saved successfully on power down or were not restored properly on     |
> +|      | power up.                                                             |
> ++------+-----------------------------------------------------------------------+
> +|  02  | SCM device contents are persisted from previous IPL. The data from    |
> +|      | the last boot were successfully restored.                             |
> ++------+-----------------------------------------------------------------------+
> +|  03  | SCM device contents are not persisted from previous IPL. There was no |
> +|      | data to restore from the last boot.                                   |
> ++------+-----------------------------------------------------------------------+
> +|  04  | SCM device memory life remaining is critically low                    |
> ++------+-----------------------------------------------------------------------+
> +|  05  | SCM device will be garded off next IPL due to failure                 |
> ++------+-----------------------------------------------------------------------+
> +|  06  | SCM contents cannot persist due to current platform health status. A  |
> +|      | hardware failure may prevent data from being saved or restored.       |
> ++------+-----------------------------------------------------------------------+
> +|  07  | SCM device is unable to persist memory contents in certain conditions |
> ++------+-----------------------------------------------------------------------+
> +|  08  | SCM device is encrypted                                               |
> ++------+-----------------------------------------------------------------------+
> +|  09  | SCM device has successfully completed a requested erase or secure     |
> +|      | erase procedure.                                                      |
> ++------+-----------------------------------------------------------------------+
> +|10:63 | Reserved / Unused                                                     |
> ++------+-----------------------------------------------------------------------+
>
>  **H_SCM_PERFORMANCE_STATS**
>
> --
> 2.26.2
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
