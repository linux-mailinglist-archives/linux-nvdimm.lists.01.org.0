Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C713071DB
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 Jan 2021 09:47:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D10AA100F2271;
	Thu, 28 Jan 2021 00:47:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0CE7A100F226E
	for <linux-nvdimm@lists.01.org>; Thu, 28 Jan 2021 00:47:32 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id c6so5708701ede.0
        for <linux-nvdimm@lists.01.org>; Thu, 28 Jan 2021 00:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHJTDgwtj8/gOzkx5b10unw8uv7UPa0RC8lalBdkj0k=;
        b=Sl4ljO2YmtxOzHjtc9IIJvu0XfftRThhJ3oo19azvPRompBAJVtJcmNF4o1rdNvMks
         yM9DBJtfSPiWFE3jJTocHhmwkBq9OMKH955WsNgP4dCEADuNjUkRUkV2LiGKaOjMdoec
         wtFZsKIpZez1nAjiagGhzS0ADiZOB0M8eiMpOYPH7OY/OJkkIFqe4Nr8vLz25B4GdDFq
         p85zqTzGOJVD6V/P5VaP68ojkLy3iMwaEO6eenkEZE6EnE6VHR7NOwCEh+jSR+3jiErh
         8MhbaUME6UrurP0/GDr1VbiiQ2mFxeXAd/f4w+7XPyWz4Y47n+/3sM5QbOgJC6J0C2Be
         wYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHJTDgwtj8/gOzkx5b10unw8uv7UPa0RC8lalBdkj0k=;
        b=crj0vij5TrZ8IO1bxoF7Nh9/59e1MGEYCSWNJt/DtDydjWeAg7NDJ7TtBUQtLdHl73
         rxdYo9h/KgjN7GF6iETk4+KZewiT+j8ltEGKlS7i89eqAUtHLTyjyc3cQUt9EWqDnYFP
         +R8x2gHKH8toLLeLdhKpuphojcuZgO9ZBfbk6GKVo2EqFzmIBQb7Vm/23fVwdLeYR5y0
         FST9pFJ22zEDiH9gh8ylTi+RTqwAvaT3biqBSGGdCIonOOixGQLB8E5Jpd6rAZLVCDuE
         zhDKQi0nSHxpFBvHy8nYZRGkdysA+T6gMb8tCxa0jOga/3PwB44Pqy1aKcPHCkCXuZL1
         8tpw==
X-Gm-Message-State: AOAM530ZwcTMNz6TKoXtrH9I1IXzfT/4sEfjKtqSs6Ektju3H0fKmzMB
	hkR2KCEzWjjJNrMzAoEp+M70bPVDcDH0Mg/KfbsDFA==
X-Google-Smtp-Source: ABdhPJwW2jdQJcrigwATW48r59SPc1Olx87ks6Ahk1hwbyLjri48wLTugoNI4XhrFAZ6y70W3y660aoG8D8Q0nzoq0Y=
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr12766424edd.52.1611823650968;
 Thu, 28 Jan 2021 00:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20200426095232.27524-1-redhairer.li@intel.com>
 <CAPcyv4gLKSMa4bN446MnRtjdfGaM-Hjy+dcYm316=4EP43G1wg@mail.gmail.com>
 <BL0PR11MB3281CBD1CC9B64389731ECE492AC0@BL0PR11MB3281.namprd11.prod.outlook.com>
 <CAPcyv4gupvktDG2PdCL6SyO4gwC1WoP8PKmPv1gP6pp8i10esQ@mail.gmail.com> <MWHPR11MB13753C37B1394CFFE124A30892A70@MWHPR11MB1375.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB13753C37B1394CFFE124A30892A70@MWHPR11MB1375.namprd11.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 28 Jan 2021 00:47:28 -0800
Message-ID: <CAPcyv4iG9XMfrhKn+vSmU2RjyeaHtiF2pprGJ6t-56uOtPNSJg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting
 relative to seed devices
To: "Li, Redhairer" <redhairer.li@intel.com>
Message-ID-Hash: YJVASYIUAG23VJFRLQ7MSZIWIFW4XEHH
X-Message-ID-Hash: YJVASYIUAG23VJFRLQ7MSZIWIFW4XEHH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YJVASYIUAG23VJFRLQ7MSZIWIFW4XEHH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 15, 2021 at 9:22 AM Li, Redhairer <redhairer.li@intel.com> wrote:
>
> Hi Dan,
>
> Your comment is make sense.
> ndctl_namespace_disable_safe will return 1 if namespace size is 0.
> I send a new patch out for review.

It looks ok but it does not apply to the current tip of tree now v71.1
can you resend?

>
> But I am not sure what do you mean for 2nd patch.
> In cmd_disable_namespace, it already print error if rc<0.
>         rc = do_xaction_namespace(namespace, ACTION_DISABLE, ctx, &disabled);
>         if (rc < 0 && !err_count)
>                 fprintf(stderr, "error disabling namespaces: %s\n",
>                                 strerror(-rc));

Hmm, you're right, once you change to the positive error code the
report will just work. Did you give it a try does it fix the
accounting problem with just your first patch?

>
> my patch is based on v70 due to latest one will see "FAIL: create.sh" when make check even not include my change.

I know of at least one create.sh failure that was fixed by:

Kernel commit:

2dd2a1740ee1 libnvdimm/namespace: Fix reaping of invalidated
block-window-namespace labels

...which is now in v5.11-rc1 and backported to v5.10-rc4. However,
that bug only started triggering after ndctl changed to reconfigure
namespaces in place with commit:

d4bc247faeda ndctl/namespace: Reconfigure in-place

..which was only merged into ndctl in v71.

Another kernel change that may be causing your failures is:

d1c5246e08eb x86/mm: Fix leak of pmd ptlock

...which was merged for v5.11-rc3 and backported to v5.10.7.

Can you run latest kernel and ndctl and see if you still see the
create.sh failure?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
