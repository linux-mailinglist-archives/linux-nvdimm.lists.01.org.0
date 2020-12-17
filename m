Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B592F2DCCEE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 08:23:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2933C100EB823;
	Wed, 16 Dec 2020 23:23:50 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3CD36100ED487
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 23:23:48 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2so18477456pfq.5
        for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 23:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=s8DTCLK1NObwq6A7yxCnWPlaLLhoDrNKlWzzd7f7Tzg=;
        b=YC3e7+XFY6jIESsbm+DNv6W8ymMnHpqnkzZEBi6bDMOCiRZbMDDIY9+Yf2N3j+wHFa
         7NrmYncT/bEyBshM3Z0L2F8N8MnNazQx/XCN3LFJDkIN+e6B0Oew/LGuSNBEPiDaudeW
         2zS4H3E6fwg0c+Y7+tnkv2uNFpFSaDayDpWS6vTnpYqNlsVPlv1h3RZtlqKTXbOsyQUX
         7XX3Np6ucOR84NZ2Vfb20WL1Rk7fZwZhA+e/lpLnSc7oMKTC4RMUhKsOGeI8YAucyPQa
         g6pNr4gfv2VJ0Mrcig0WC18dgkeQ1ovGGFh5DecipzKdj202xDZ5JS53ymWzP+agDZFz
         qgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=s8DTCLK1NObwq6A7yxCnWPlaLLhoDrNKlWzzd7f7Tzg=;
        b=rvn73DLyLe4To2K+6BEV903zTaOQkA/8pZiQlttGbdkfNY3JiUSiRbd9jkfdxz3BEf
         XWMGrX18bgw4aw8r57BYb4hR8ieXMQXA/sAUaAlJbioFWzboRKDk+MJ6mYEjUlYdmlaZ
         iAkylWFDMMa/7i09s6A+pIR+TujHEfhyolY8dDsKch25oCm5qToFFj/VAjUlKczKtJCK
         QTo63bX4ZA2s6HWTbltEbvySDNpUuIhW4LN+73id2xKvODoFaCkQ1a3TtotBSAwsfWp3
         32nhukgwXVRtRumCE76TjJp6A3QD5F+lYyYiPhzn18tLcL87oNd8j2YYvuN33KqCXXq5
         Uh4g==
X-Gm-Message-State: AOAM5311AdMXqKFQe9jJPhkGl9SrzGh0jizBXkrbfgJh35wf2Be/f9Vh
	2FHFwiXMls2++RNMC5yzcai0nA==
X-Google-Smtp-Source: ABdhPJwtyh1kh0p/aYSEfQj6H3dAY6mC7maviVFDOhZFYrjW0g/nCJt0bSQpgXdyFfH/36wsuZIZ3w==
X-Received: by 2002:a62:1617:0:b029:1a3:c265:a50c with SMTP id 23-20020a6216170000b02901a3c265a50cmr8123120pfw.77.1608189827425;
        Wed, 16 Dec 2020 23:23:47 -0800 (PST)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id y6sm4475630pjl.0.2020.12.16.23.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 23:23:46 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC v5 0/7] PMEM device emulation without nfit depenency
In-Reply-To: <CAPcyv4iDGN8Z=uXHrgo8Zs=Br6xbsmZsJ6VAcQVZXd=d9Nkoew@mail.gmail.com>
References: <20201214103859.2409175-1-santosh@fossix.org>
 <CAPcyv4iDGN8Z=uXHrgo8Zs=Br6xbsmZsJ6VAcQVZXd=d9Nkoew@mail.gmail.com>
Date: Thu, 17 Dec 2020 12:53:44 +0530
Message-ID: <87o8is520v.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: LVI2MSPFF2TXP6A5UWTV5H7ZTVXDCAVP
X-Message-ID-Hash: LVI2MSPFF2TXP6A5UWTV5H7ZTVXDCAVP
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LVI2MSPFF2TXP6A5UWTV5H7ZTVXDCAVP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> Typically RFC means "not ready to apply, still seeking fundamental
> approach feedback". Should I be looking to consider this for
> v5.11-rc1, or is this still RFC / should wait for v5.12?

I would like this to go in, after your comments to the previously RFC, I guess
this has moved beyond the RFC tag. I will re-send the series without the RFC
tag. Meanwhile I will continue to work on getting both modules to co-exist and
be exercised in the same build apart from getting SMART and error injection
tests.

>
> On Mon, Dec 14, 2020 at 2:39 AM Santosh Sivaraj <santosh@fossix.org> wrote:
>>
>> The current test module cannot be used for testing platforms (make check)
>> that do not have support for NFIT. In order to get the ndctl tests working,
>> we need a module which can emulate NVDIMM devices without relying on
>> ACPI/NFIT.
>>
>> The emulated PMEM device is made part of the PAPR family.
>>
>> Corresponding changes for ndctl is also required, to add attributes needed
>> for the test, which will be sent as a reply to this patch.
>>
>> The following is the test result, run on a x86 guest:
>>
>> PASS: libndctl
>> PASS: dsm-fail
>> PASS: dpa-alloc
>> PASS: parent-uuid
>> PASS: multi-pmem
>> PASS: create.sh
>> FAIL: clear.sh
>> FAIL: pmem-errors.sh
>> FAIL: daxdev-errors.sh
>> PASS: multi-dax.sh
>> PASS: btt-check.sh
>> FAIL: label-compat.sh
>> PASS: blk-exhaust.sh
>> PASS: sector-mode.sh
>> FAIL: inject-error.sh
>> SKIP: btt-errors.sh
>> PASS: hugetlb
>> PASS: btt-pad-compat.sh
>> SKIP: firmware-update.sh
>> FAIL: ack-shutdown-count-set
>> PASS: rescan-partitions.sh
>> FAIL: inject-smart.sh
>> FAIL: monitor.sh
>> PASS: max_available_extent_ns.sh
>> FAIL: pfn-meta-errors.sh
>> PASS: track-uuid.sh
>> ============================================================================
>> Testsuite summary for ndctl 70.10.g7ecd11c
>> ============================================================================
>> # TOTAL: 26
>> # PASS:  15
>> # SKIP:  2
>> # XFAIL: 0
>> # FAIL:  9
>> # XPASS: 0
>> # ERROR: 0
>>
>> The following is the test result from a PowerPC 64 guest.
>>
>> PASS: libndctl
>> PASS: dsm-fail
>> PASS: dpa-alloc
>> PASS: parent-uuid
>> PASS: multi-pmem
>> PASS: create.sh
>> FAIL: clear.sh
>> FAIL: pmem-errors.sh
>> FAIL: daxdev-errors.sh
>> PASS: multi-dax.sh
>> PASS: btt-check.sh
>> FAIL: label-compat.sh
>> PASS: blk-exhaust.sh
>> PASS: sector-mode.sh
>> FAIL: inject-error.sh
>> SKIP: btt-errors.sh
>> SKIP: hugetlb
>> PASS: btt-pad-compat.sh
>> SKIP: firmware-update.sh
>> FAIL: ack-shutdown-count-set
>> PASS: rescan-partitions.sh
>> FAIL: inject-smart.sh
>> FAIL: monitor.sh
>> PASS: max_available_extent_ns.sh
>> FAIL: pfn-meta-errors.sh
>> PASS: track-uuid.sh
>> ============================================================================
>> Testsuite summary for ndctl 70.git94a00679
>> ============================================================================
>> # TOTAL: 26
>> # PASS:  14
>> # SKIP:  3
>> # XFAIL: 0
>> # FAIL:  9
>> # XPASS: 0
>> # ERROR: 0
>
> With these run reports are you trying to demonstrate the improvement,
> or the future work?

This shows what work still needs to be done. As of now there is SMART and error
injection which I am working on right now.
>
> I think it's sufficient to say that no tests ran with nfit_test
> previously, but now 26 pass. Extra interesting would be to determine
> if any current papr regression fixes in the tree would have been
> caught by an ndtest run.

So far there is are no regressions caught.

Thanks,
Santosh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
