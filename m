Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCF41EFFD2
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jun 2020 20:19:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4345B1009F03B;
	Fri,  5 Jun 2020 11:14:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 767961009F039
	for <linux-nvdimm@lists.01.org>; Fri,  5 Jun 2020 11:14:28 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e12so8198545eds.2
        for <linux-nvdimm@lists.01.org>; Fri, 05 Jun 2020 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqSUfhL+HpfxHMHLxeDxo+cffKJm8uC5qt8/bLSPpbQ=;
        b=KFZS46GFTZ9Gy3Cg/ohafbBdin5UVGOHBKY0W2wI6384HxS9k1vLbbdkOtccGTBnfl
         8XcGqVZeS/TWjJAU9xBTxX6LY+5e3X4A4jUvLcQ2fUqGlmj9zxKy89nhC7UsResG1jCn
         qcYVtf6k/prKJ895tWtyIpNpncfHOSytxbTBzmcHYmUtmZ5VtKm5h7WitDT3/e4vO2wb
         FeAk5ZwfXuLAHuSnbVvQTreK2q8TTD3kW2ol12V7p7CDK6LR5q9MgL+ZZM2BYHDuA3DN
         SGWwD6HEw6x3yX57rz+veZOXIf31k/GhdrbzYfVn74/XVgE4Qnr1acJHTuaoW0SjZHH+
         J/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqSUfhL+HpfxHMHLxeDxo+cffKJm8uC5qt8/bLSPpbQ=;
        b=goD//+3HVXP11ZTX4/lCVlarA43YfzGgurmItI4FLAPV7ObHZ498gCgXdPl2D3CIvz
         r1lA1LLZW1CwgkDJH6ajHEesq3sTPzW9PNSFTKdIkX/Vc28Nzi1E0UdULOkgjO+AqXEs
         gmgz4GzfhMpVUrPFgH9j1I8CzjHlmgfPd3Bq663/9dVoga1EaaxRkGAaZjAtDZx81906
         qK0P9+daTlZryaNSwz+fnpfDqjOMYkXvwZjQf97XzUnLpcSpZlu1DwjNsoReYxkSfaAk
         fI7/o3/x4jPPoHJBICpZSnLHXC7SGUbrWvYbADk+xKmEoWr6m/HT9FsYRQJvyLCGg1Ip
         LNhA==
X-Gm-Message-State: AOAM53025ZWGVyP2U+ri7fxFSxpgKu9Rn5dxtxDdN2biLcT6RSK8gB4y
	vV1e8zgbDBafFy2a8p4/luyqMASopJsolHNBGEvgsg==
X-Google-Smtp-Source: ABdhPJwYKATWO9a3ADTUxQBAa8Nwr2+GQoHSj84HHGLL7MmG5YsI5pBuAWt+4WD3LOSfh0YCGx6dzCQDPaOgqo80aV8=
X-Received: by 2002:aa7:d6c1:: with SMTP id x1mr6359975edr.154.1591381179201;
 Fri, 05 Jun 2020 11:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200602101438.73929-1-vaibhav@linux.ibm.com> <20200602101438.73929-5-vaibhav@linux.ibm.com>
 <BN6PR11MB413223B333153721405DFD91C6890@BN6PR11MB4132.namprd11.prod.outlook.com>
 <87h7vrgpzx.fsf@linux.ibm.com> <BN6PR11MB4132FA66A84CBD798AADCEC1C6860@BN6PR11MB4132.namprd11.prod.outlook.com>
 <873679h72g.fsf@linux.ibm.com>
In-Reply-To: <873679h72g.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 5 Jun 2020 11:19:27 -0700
Message-ID: <CAPcyv4jcWc6HOW5dK1hp0vATDxd_mo+eVK=xkYMPOQ7t1fCv-A@mail.gmail.com>
Subject: Re: [RESEND PATCH v9 4/5] ndctl/papr_scm,uapi: Add support for PAPR
 nvdimm specific methods
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Message-ID-Hash: AO5JB4GEPJM23OAD7PALD5INQKNVBAS2
X-Message-ID-Hash: AO5JB4GEPJM23OAD7PALD5INQKNVBAS2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AO5JB4GEPJM23OAD7PALD5INQKNVBAS2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 5, 2020 at 8:22 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
[..]
> > Oh, why not define a maximal health payload with all the attributes
> > you know about today, leave some room for future expansion, and then
> > report a validity flag for each attribute? This is how the "intel"
> > smart-health payload works. If they ever needed to extend the payload
> > they would increase the size and add more validity flags. Old
> > userspace never groks the new fields, new userspace knows to ask for
> > and parse the larger payload.
> >
> > See the flags field in 'struct nd_intel_smart' (in ndctl) and the
> > translation of those flags to ndctl generic attribute flags
> > intel_cmd_smart_get_flags().
> >
> > In general I'd like ndctl to understand the superset of all health
> > attributes across all vendors. For the truly vendor specific ones it
> > would mean that the health flags with a specific "papr_scm" back-end
> > just would never be set on an "intel" device. I.e. look at the "hpe"
> > and "msft" health backends. They only set a subset of the valid flags
> > that could be reported.
>
> Thanks, this sounds good. Infact papr_scm implementation in ndctl does
> advertises support for only a subset of ND_SMART_* flags right now.
>
> Using 'flags' instead of 'version' was indeed discussed during
> v7..v9. However re-looking at the 'msft' and 'hpe' implementations the
> approach of maximal health payload tagged with a flags field looks more
> intuitive and I would prefer implementing this scheme in this patch-set.
>
> The current set health data exchanged with between libndctl and
> papr_scm via 'struct nd_papr_pdsm_health' (e.g various health status
> bits , nvdimm arming status etc) are guaranteed to be always available
> hence associating their availability with a flag wont be much useful as
> the flag will be always set.
>
> However as you suggested, extending the 'struct nd_papr_pdsm_health' in
> future to accommodate new attributes like 'life-remaining' can be done
> via adding them to the end of the struct and setting a flag field to
> indicate its presence.
>
> So I have the following proposal:
> * Add a new '__u32 extension_flags' field at beginning of 'struct
>   nd_papr_pdsm_health'
> * Set the size of the struct to 184-bytes which is the maximum possible
>   size for a pdsm payload.
> * 'papr_scm' kernel driver will currently set 'extension_flag' to 0
>   indicating no extension fields.
>
> * Future patch that adds support for 'life-remaining' add the new-field
>   at the end of known fields in 'struct nd_papr_pdsm_health'.
> * When provided to  papr_scm kernel module, if 'life-remaining' data is
>   available its populated and corresponding flag set in
>   'extension_flags' field indicating its presence.
> * When received by libndctl papr_scm implementation its tests if the
>   extension_flags have associated 'life-remaining' flag set and if yes
>   then return ND_SMART_USED_VALID flag back from
>   ndctl_cmd_smart_get_flags().
>
> Implementing first 3 items above in the current patchset should be
> fairly trivial.
>
> Does that sounds reasonable ?

This sounds good to me.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
