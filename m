Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFE92DADC7
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Dec 2020 14:11:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 11921100EBBD6;
	Tue, 15 Dec 2020 05:11:40 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f48; helo=mail-qv1-xf48.google.com; envelope-from=3brbyxwkjdnk89i856wwebh5dg.7jhgdips-iq8dhhgdnon.vw.jmb@trix.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-qv1-xf48.google.com (mail-qv1-xf48.google.com [IPv6:2607:f8b0:4864:20::f48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4241D100EBBD5
	for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 05:11:37 -0800 (PST)
Received: by mail-qv1-xf48.google.com with SMTP id 102so14197106qva.0
        for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 05:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:message-id:date:subject:from:to;
        bh=o5P0II6McdT0hVialUiWO+NHvIrzsPav1TeEV+Uh33c=;
        b=nKtb8mMtrNlvYl8M3/SB7FiwGak3XSbpCVJiuAIJs3DJkKvVpC3dvtSLi64Mv8RKda
         dkHK9AxJApKmUqCGrf3hKEs6Ywc8JIW2S3Eg1Pbbj4RklR9nVbz5wyxuHJ6nM9QGhCil
         roDeqarE6KYx1kwcCvXfoI0QfzQNnS3WcDF5ZBwGvk1sgHyHnT133FBBPnuxTv91aCOe
         9C6PYqBmYGsqQ2Gwg4HWnhuPvMI6Gdhw0lU894rUqG56xx4ulx7bEaARWK8SsQVvJGe5
         33NGPpgNSbWEZuQDmhkX8vy2NdRRif3+1HRU80jl/cIVJcmJIhpX+iGkmi6YhsATHvyn
         XneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:message-id:date:subject
         :from:to;
        bh=o5P0II6McdT0hVialUiWO+NHvIrzsPav1TeEV+Uh33c=;
        b=aXCUJl2Cv/L4+8/tqXdnavMRUZsMKOK3IFUlxRi4CnLcc0tlnxZ9Fm7BDymOed8QPL
         z2KPap6U6otr/8Qpb8XMBY1NRxUQiYiwopFNWs8HVgmFbolGi419dJni7aFTRWmlSiui
         uppdjT6cd15Nis5fvPEwdV9SFqouE2g0dy1O5MVG7jUoMDflUWsprizgo22y4ZbbxWH3
         0sKXK1IQUX393abFSHL8C6GHdxHKBARUs+BDj90B/PmuGtgPnC84GDgF7hRztT6Er97H
         PYXi3h6Vbi04OAW9PWWfTbr+SFNStDadTFCfwCczRiMLmAH54ndjACvMekmtX2/VlEAu
         XgWA==
X-Gm-Message-State: AOAM531TUPV49xyli53YmfetY9IwaNXqyJE2ZUV9oc+PG2pfVtBVz/mq
	MMHVup1A/F8uo5ADrE5hnpCRgOgZL4kQg64NBIp+
MIME-Version: 1.0
X-Received: by 2002:ad4:4e09:: with SMTP id dl9mt37491883qvb.44.1608037894111;
 Tue, 15 Dec 2020 05:11:34 -0800 (PST)
X-No-Auto-Attachment: 1
Message-ID: <00000000000076df7105b6807f46@google.com>
Date: Tue, 15 Dec 2020 13:11:36 +0000
Subject: HOW ARE YOU?
From: dendab119@gmail.com
To: linux-nvdimm@lists.01.org
Message-ID-Hash: BCOO5IZ72GRBMTCOYHI3IFJODDMHKPSN
X-Message-ID-Hash: BCOO5IZ72GRBMTCOYHI3IFJODDMHKPSN
X-MailFrom: 3BrbYXwkJDNk89I856WWeBH5DG.7JHGDIPS-IQ8DHHGDNON.VW.JMB@trix.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: dendab119@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BCOO5IZ72GRBMTCOYHI3IFJODDMHKPSN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"; delsp="yes"
Content-Transfer-Encoding: base64

SmUgdm91cyBhaSBpbnZpdMOpIMOgIHJlbXBsaXIgbGUgZm9ybXVsYWlyZSBzdWl2YW50wqA6DQpG
b3JtdWxhaXJlIHNhbnMgdGl0cmUNCg0KUG91ciByZW1wbGlyIGNlIGZvcm11bGFpcmUsIGNvbnN1
bHRlesKgOg0KaHR0cHM6Ly9kb2NzLmdvb2dsZS5jb20vZm9ybXMvZC9lLzFGQUlwUUxTZC1pZjBS
d2JqUUQ2M0xhV1hEYjZGc1ZpRHFpeXNvZXIyOHAwNzZiSnNaOS11REFnL3ZpZXdmb3JtP3ZjPTAm
YW1wO2M9MCZhbXA7dz0xJmFtcDtmbHI9MCZhbXA7dXNwPW1haWxfZm9ybV9saW5rDQoNCkhlbGxv
IE15IERlYXIsDQoNCkkgaG9wZSB0aGlzIGxldHRlciBmaW5kcyB5b3Ugd2VsbC4NCg0KTXkgbmFt
ZSBpcyBFa291w6kgRGpybyBHTE9LUE9SLiBBbnl3YXksIEkgYW0gaW4gcG9zaXRpb24gb2YgZWxp
Z2libGUgRlVORCB0byAgDQp0cmFuc2ZlciBmb3IgSW52ZXN0bWVudCBQdXJwb3NlIGFzIGEgc291
cmNlIG9mIEZ1bmRpbmcgUHJvamVjdHMuIEFuZCB1cG9uICANCnlvdXIgYWNrbm93bGVkZ21lbnQg
b2YgcmVjZWl2aW5nIHRoaXMgTWVzc2FnZSBJIHdpbGwgcHJvdmlkZSB5b3UgZnVydGhlciAgDQpp
bmZvcm1hdGlvbiBpbiBGdWxsIERldGFpbHMuDQoNClBsZWFzZSByZXBseSB0bzogZWRnbG9rcG9y
QGFvbC5jb20NCg0KSSBhd2FpdCB5b3VyIENvbmZpcm1hdGlvbiBSZXNwb25zZS4NCg0KQmVzdCBS
ZWdhcmRzLA0KTXIuIEVrb3XDqSBEanJvIEdMT0tQT1IuDQoNCg0KDQoNCg0KR29vZ2xlwqBGb3Jt
cyB2b3VzIHBlcm1ldCBkZSBjcsOpZXIgZGVzIGVucXXDqnRlcyBldCBkJ2VuIGFuYWx5c2VyIGxl
cyAgDQpyw6lzdWx0YXRzLg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMu
MDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZl
QGxpc3RzLjAxLm9yZwo=
